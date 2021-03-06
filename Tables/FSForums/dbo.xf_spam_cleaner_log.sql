/****** Object:  Table [dbo].[xf_spam_cleaner_log]    Script Date: 5/15/2018 12:00:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_spam_cleaner_log](
	[spam_cleaner_log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[applying_user_id] [bigint] NOT NULL,
	[applying_username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[application_date] [bigint] NOT NULL,
	[data] [varbinary](max) NOT NULL,
	[restored_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_spam_cleaner_log_spam_cleaner_log_id] PRIMARY KEY CLUSTERED 
(
	[spam_cleaner_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [application_date]    Script Date: 5/15/2018 12:00:34 PM ******/
CREATE NONCLUSTERED INDEX [application_date] ON [dbo].[xf_spam_cleaner_log]
(
	[application_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_spam_cleaner_log] ADD  DEFAULT ((0)) FOR [user_id]
ALTER TABLE [dbo].[xf_spam_cleaner_log] ADD  DEFAULT (N'') FOR [username]
ALTER TABLE [dbo].[xf_spam_cleaner_log] ADD  DEFAULT ((0)) FOR [applying_user_id]
ALTER TABLE [dbo].[xf_spam_cleaner_log] ADD  DEFAULT (N'') FOR [applying_username]
ALTER TABLE [dbo].[xf_spam_cleaner_log] ADD  DEFAULT ((0)) FOR [application_date]
ALTER TABLE [dbo].[xf_spam_cleaner_log] ADD  DEFAULT ((0)) FOR [restored_date]
GO
