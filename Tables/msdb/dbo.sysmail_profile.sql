/****** Object:  Table [dbo].[sysmail_profile]    Script Date: 5/15/2018 12:03:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmail_profile](
	[profile_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_mod_datetime] [datetime] NOT NULL,
	[last_mod_user] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [SYSMAIL_PROFILE_IDMustBeUnique] PRIMARY KEY CLUSTERED 
(
	[profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [SYSMAIL_PROFILE_NameMustBeUnique] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sysmail_profile] ADD  DEFAULT (getdate()) FOR [last_mod_datetime]
ALTER TABLE [dbo].[sysmail_profile] ADD  DEFAULT (suser_sname()) FOR [last_mod_user]
/****** Object:  Trigger [dbo].[trig_sysmail_profile]    Script Date: 5/15/2018 12:03:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE TRIGGER trig_sysmail_profile
ON msdb.dbo.sysmail_profile
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON  

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_profile'), 'AFTER' , 'DML' ) <= 1) 
   BEGIN  
      UPDATE msdb.dbo.sysmail_profile 
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname() 
      FROM sysmail_profile p, inserted i
      WHERE p.profile_id = i.profile_id
   END
END

/****** Object:  Trigger [dbo].[trig_sysmail_profile_delete]    Script Date: 5/15/2018 12:03:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE TRIGGER trig_sysmail_profile_delete
ON msdb.dbo.sysmail_profile
FOR DELETE
AS
BEGIN
   DELETE FROM msdb.dbo.sysmail_profileaccount
   WHERE profile_id IN (SELECT profile_id FROM deleted)
END

GO
