/****** Object:  Table [dbo].[phpkb_authors]    Script Date: 5/15/2018 11:59:16 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_authors](
	[author_id] [int] IDENTITY(1,1) NOT NULL,
	[author_name] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author_status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author_username] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author_password] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author_email] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author_level] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author_flag] [int] NULL,
	[author_signup_date_time] [smalldatetime] NOT NULL,
	[author_last_login] [smalldatetime] NOT NULL,
	[author_forgot_password] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[author_forgot_password_token] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[author_login_session] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [author_id] PRIMARY KEY CLUSTERED 
(
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[author_username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_authors] ADD  DEFAULT ('inactive') FOR [author_status]
ALTER TABLE [dbo].[phpkb_authors] ADD  DEFAULT ('Member') FOR [author_level]
ALTER TABLE [dbo].[phpkb_authors] ADD  DEFAULT ('0') FOR [author_flag]
ALTER TABLE [dbo].[phpkb_authors] ADD  DEFAULT (NULL) FOR [author_forgot_password]
ALTER TABLE [dbo].[phpkb_authors] ADD  DEFAULT (NULL) FOR [author_forgot_password_token]
ALTER TABLE [dbo].[phpkb_authors] ADD  DEFAULT (NULL) FOR [author_login_session]
ALTER TABLE [dbo].[phpkb_authors]  WITH CHECK ADD CHECK  (([author_status]='inactive' OR [author_status]='active'))
ALTER TABLE [dbo].[phpkb_authors]  WITH CHECK ADD CHECK  (([author_level]='Member' OR [author_level]='Writer-Trusted' OR [author_level]='Writer' OR [author_level]='Editor' OR [author_level]='Superuser'))
GO
