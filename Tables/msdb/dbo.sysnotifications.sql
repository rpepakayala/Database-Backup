/****** Object:  Table [dbo].[sysnotifications]    Script Date: 5/15/2018 12:03:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysnotifications](
	[alert_id] [int] NOT NULL,
	[operator_id] [int] NOT NULL,
	[notification_method] [tinyint] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [ByAlertIDAndOperatorID]    Script Date: 5/15/2018 12:03:08 PM ******/
CREATE UNIQUE CLUSTERED INDEX [ByAlertIDAndOperatorID] ON [dbo].[sysnotifications]
(
	[alert_id] ASC,
	[operator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Trigger [dbo].[trig_notification_delete]    Script Date: 5/15/2018 12:03:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE TRIGGER trig_notification_delete
ON msdb.dbo.sysnotifications
FOR DELETE
AS
BEGIN
  SET NOCOUNT ON

  -- Reset the has_notification flag for the affected alerts
  UPDATE msdb.dbo.sysalerts
  SET has_notification = 0
  FROM deleted            d,
       msdb.dbo.sysalerts sa
  WHERE (d.alert_id = sa.id)

  -- Update sysalerts.has_notification (for email)
  UPDATE msdb.dbo.sysalerts
  SET has_notification = has_notification | 1
  FROM msdb.dbo.sysalerts        sa,
       msdb.dbo.sysnotifications sn,
       deleted                   d
  WHERE (sa.id = sn.alert_id)
    AND (sa.id = d.alert_id)
    AND ((sn.notification_method & 1) = 1)

  -- Update sysalerts.has_notification (for pager)
  UPDATE msdb.dbo.sysalerts
  SET has_notification = has_notification | 2
  FROM msdb.dbo.sysalerts        sa,
       msdb.dbo.sysnotifications sn,
       deleted                   d
  WHERE (sa.id = sn.alert_id)
    AND (sa.id = d.alert_id)
    AND ((sn.notification_method & 2) = 2)

  -- Update sysalerts.has_notification (for netsend)
  UPDATE msdb.dbo.sysalerts
  SET has_notification = has_notification | 4
  FROM msdb.dbo.sysalerts        sa,
       msdb.dbo.sysnotifications sn,
       deleted                   d
  WHERE (sa.id = sn.alert_id)
    AND (sa.id = d.alert_id)
    AND ((sn.notification_method & 4) = 4)
END

/****** Object:  Trigger [dbo].[trig_notification_ins_or_upd]    Script Date: 5/15/2018 12:03:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE TRIGGER trig_notification_ins_or_upd
ON msdb.dbo.sysnotifications
FOR INSERT,
    UPDATE
AS
BEGIN
  SET NOCOUNT ON

  -- First, throw out 'non-notification' rows
  DELETE FROM msdb.dbo.sysnotifications
  WHERE (notification_method = 0)

  -- Reset the has_notification flag for the affected alerts
  UPDATE msdb.dbo.sysalerts
  SET has_notification = 0
  FROM inserted           i,
       msdb.dbo.sysalerts sa
  WHERE (i.alert_id = sa.id)

  -- Update sysalerts.has_notification (for email)
  UPDATE msdb.dbo.sysalerts
  SET has_notification = has_notification | 1
  FROM msdb.dbo.sysalerts        sa,
       msdb.dbo.sysnotifications sn,
       inserted                  i
  WHERE (sa.id = sn.alert_id)
    AND (sa.id = i.alert_id)
    AND ((sn.notification_method & 1) = 1)

  -- Update sysalerts.has_notification (for pager)
  UPDATE msdb.dbo.sysalerts
  SET has_notification = has_notification | 2
  FROM msdb.dbo.sysalerts        sa,
       msdb.dbo.sysnotifications sn,
       inserted                  i
  WHERE (sa.id = sn.alert_id)
    AND (sa.id = i.alert_id)
    AND ((sn.notification_method & 2) = 2)

  -- Update sysalerts.has_notification (for netsend)
  UPDATE msdb.dbo.sysalerts
  SET has_notification = has_notification | 4
  FROM msdb.dbo.sysalerts        sa,
       msdb.dbo.sysnotifications sn,
       inserted                  i
  WHERE (sa.id = sn.alert_id)
    AND (sa.id = i.alert_id)
    AND ((sn.notification_method & 4) = 4)
END

GO
