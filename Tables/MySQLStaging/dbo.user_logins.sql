/****** Object:  Table [dbo].[user_logins]    Script Date: 5/15/2018 12:04:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[user_logins](
	[user_login_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[username] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[password] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[salt] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[active] [smallint] NOT NULL,
	[token] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[user_logins] ADD  DEFAULT (NULL) FOR [token]
GO
