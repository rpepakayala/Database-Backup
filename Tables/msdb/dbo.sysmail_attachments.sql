/****** Object:  Table [dbo].[sysmail_attachments]    Script Date: 5/15/2018 12:03:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmail_attachments](
	[attachment_id] [int] IDENTITY(1,1) NOT NULL,
	[mailitem_id] [int] NOT NULL,
	[filename] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[filesize] [int] NOT NULL,
	[attachment] [varbinary](max) NULL,
	[last_mod_date] [datetime] NOT NULL,
	[last_mod_user] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sysmail_attachments] ADD  DEFAULT (getdate()) FOR [last_mod_date]
ALTER TABLE [dbo].[sysmail_attachments] ADD  DEFAULT (suser_sname()) FOR [last_mod_user]
ALTER TABLE [dbo].[sysmail_attachments]  WITH CHECK ADD  CONSTRAINT [FK_sysmail_mailitems_mailitem_id] FOREIGN KEY([mailitem_id])
REFERENCES [dbo].[sysmail_mailitems] ([mailitem_id])
ON DELETE CASCADE
ALTER TABLE [dbo].[sysmail_attachments] CHECK CONSTRAINT [FK_sysmail_mailitems_mailitem_id]
/****** Object:  Trigger [dbo].[trig_sysmail_attachments]    Script Date: 5/15/2018 12:03:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE TRIGGER trig_sysmail_attachments
ON msdb.dbo.sysmail_attachments
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON  

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_attachments'), 'AFTER' , 'DML' ) <= 1) 
   BEGIN  
      UPDATE msdb.dbo.sysmail_attachments 
      SET last_mod_date = GETDATE(), last_mod_user = SUSER_SNAME() 
      FROM sysmail_attachments a, inserted i
      WHERE a.attachment_id = i.attachment_id
   END
END

GO
