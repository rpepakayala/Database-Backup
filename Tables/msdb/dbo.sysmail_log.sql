/****** Object:  Table [dbo].[sysmail_log]    Script Date: 5/15/2018 12:03:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmail_log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[event_type] [int] NOT NULL,
	[log_date] [datetime] NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[process_id] [int] NULL,
	[mailitem_id] [int] NULL,
	[account_id] [int] NULL,
	[last_mod_date] [datetime] NOT NULL,
	[last_mod_user] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [sysmail_log_id_MustBeUnique] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sysmail_log] ADD  DEFAULT (getdate()) FOR [log_date]
ALTER TABLE [dbo].[sysmail_log] ADD  DEFAULT (getdate()) FOR [last_mod_date]
ALTER TABLE [dbo].[sysmail_log] ADD  DEFAULT (suser_sname()) FOR [last_mod_user]
/****** Object:  Trigger [dbo].[trig_sysmail_log]    Script Date: 5/15/2018 12:03:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE TRIGGER trig_sysmail_log
ON msdb.dbo.sysmail_log
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON  

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_log'), 'AFTER' , 'DML' ) <= 1) 
   BEGIN  
      UPDATE msdb.dbo.sysmail_log 
      SET last_mod_date = GETDATE(), last_mod_user = SUSER_SNAME() 
      FROM sysmail_log l, inserted i
      WHERE l.log_id = i.log_id
   END
END

GO
