/****** Object:  Table [dbo].[Mailer]    Script Date: 5/15/2018 11:59:25 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Mailer](
	[distinguishedName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[objectCategory] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[objectGUID] [uniqueidentifier] NULL,
	[whenCreated] [datetime] NULL,
	[department] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[displayName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sAMAccountName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mail] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[manager] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[altRecipient] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pwdLastSet] [datetime] NULL,
	[EmailSent] [bit] NULL
) ON [PRIMARY]

GO
