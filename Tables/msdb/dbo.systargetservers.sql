/****** Object:  Table [dbo].[systargetservers]    Script Date: 5/15/2018 12:03:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[systargetservers](
	[server_id] [int] IDENTITY(1,1) NOT NULL,
	[server_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[location] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[time_zone_adjustment] [int] NOT NULL,
	[enlist_date] [datetime] NOT NULL,
	[last_poll_date] [datetime] NOT NULL,
	[status] [int] NOT NULL,
	[local_time_at_last_poll] [datetime] NOT NULL,
	[enlisted_by_nt_user] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[poll_interval] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:13 PM ******/
CREATE UNIQUE CLUSTERED INDEX [clust] ON [dbo].[systargetservers]
(
	[server_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [nc1]    Script Date: 5/15/2018 12:03:13 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [nc1] ON [dbo].[systargetservers]
(
	[server_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Trigger [dbo].[trig_targetserver_insert]    Script Date: 5/15/2018 12:03:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE TRIGGER trig_targetserver_insert
ON msdb.dbo.systargetservers
FOR INSERT, DELETE
AS
BEGIN
  SET NOCOUNT ON

  -- Disallow the insert if the server is called 'ALL'
  -- NOTE: We have to do this check here in the trigger since there is no sp_add_targetserver
  --       (target servers insert a row for themselves when they 'enlist' in an MSX)
  IF (EXISTS (SELECT *
              FROM inserted
              WHERE (server_name = N'ALL')))
  BEGIN
    DELETE FROM msdb.dbo.systargetservers
    WHERE (server_name = N'ALL')
    RAISERROR(14271, -1, -1, 'ALL')
    RETURN
  END

  -- Set (or delete) the registy flag (so that SETUP can detect if we're an MSX)
  IF ((SELECT COUNT(*)
       FROM msdb.dbo.systargetservers) = 0)
  BEGIN
    DECLARE @val INT

    EXECUTE master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',
                                           N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
                                           N'MSXServer',
                                           @val OUTPUT,
                                           N'no_output'
    IF (@val IS NOT NULL)
      EXECUTE master.dbo.xp_instance_regdeletevalue N'HKEY_LOCAL_MACHINE',
                                                    N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
                                                    N'MSXServer'
  END
  ELSE
    EXECUTE master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE',
                                            N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
                                            N'MSXServer',
                                            N'REG_DWORD',
                                            1
END

GO
