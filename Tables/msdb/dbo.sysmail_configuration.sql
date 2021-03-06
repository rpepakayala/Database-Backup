/****** Object:  Table [dbo].[sysmail_configuration]    Script Date: 5/15/2018 12:03:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmail_configuration](
	[paramname] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[paramvalue] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_mod_datetime] [datetime] NOT NULL,
	[last_mod_user] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [SYSMAIL_CONFIGURATION_ParamnameMustBeUnique] PRIMARY KEY CLUSTERED 
(
	[paramname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sysmail_configuration] ADD  DEFAULT (getdate()) FOR [last_mod_datetime]
ALTER TABLE [dbo].[sysmail_configuration] ADD  DEFAULT (suser_sname()) FOR [last_mod_user]
/****** Object:  Trigger [dbo].[trig_sysmail_configuration]    Script Date: 5/15/2018 12:03:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE TRIGGER trig_sysmail_configuration
ON msdb.dbo.sysmail_configuration
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON  

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_configuration'), 'AFTER' , 'DML' ) <= 1) 
   BEGIN  
      UPDATE msdb.dbo.sysmail_configuration 
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname() 
      FROM sysmail_configuration c, inserted i
      WHERE c.paramname = i.paramname
   END
END

GO
