/****** Object:  Table [dbo].[sysmail_account]    Script Date: 5/15/2018 12:03:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmail_account](
	[account_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[email_address] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[display_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[replyto_address] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_mod_datetime] [datetime] NOT NULL,
	[last_mod_user] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [SYSMAIL_ACCOUNT_IDMustBeUnique] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [SYSMAIL_ACCOUNT_NameMustBeUnique] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sysmail_account] ADD  DEFAULT (getdate()) FOR [last_mod_datetime]
ALTER TABLE [dbo].[sysmail_account] ADD  DEFAULT (suser_sname()) FOR [last_mod_user]
/****** Object:  Trigger [dbo].[trig_sysmail_account]    Script Date: 5/15/2018 12:03:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE TRIGGER trig_sysmail_account
ON msdb.dbo.sysmail_account
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON  

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_account'), 'AFTER' , 'DML' ) <= 1) 
   BEGIN  
      UPDATE msdb.dbo.sysmail_account 
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname() 
      FROM sysmail_account a, inserted i
      WHERE a.account_id = i.account_id
   END
END

GO
