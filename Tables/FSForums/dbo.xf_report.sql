/****** Object:  Table [dbo].[xf_report]    Script Date: 5/15/2018 12:00:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_report](
	[report_id] [bigint] IDENTITY(11,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[content_user_id] [bigint] NOT NULL,
	[content_info] [varbinary](max) NOT NULL,
	[first_report_date] [bigint] NOT NULL,
	[report_state] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[assigned_user_id] [bigint] NOT NULL,
	[comment_count] [bigint] NOT NULL,
	[last_modified_date] [bigint] NOT NULL,
	[last_modified_user_id] [bigint] NOT NULL,
	[last_modified_username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[report_count] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_report_report_id] PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_report$content_type_content_id] UNIQUE NONCLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [assigned_user_id_state]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [assigned_user_id_state] ON [dbo].[xf_report]
(
	[assigned_user_id] ASC,
	[report_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [content_user_id_modified]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [content_user_id_modified] ON [dbo].[xf_report]
(
	[content_user_id] ASC,
	[last_modified_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [last_modified_date]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [last_modified_date] ON [dbo].[xf_report]
(
	[last_modified_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [report_state]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [report_state] ON [dbo].[xf_report]
(
	[report_state] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_report] ADD  DEFAULT ((0)) FOR [comment_count]
ALTER TABLE [dbo].[xf_report] ADD  DEFAULT ((0)) FOR [last_modified_user_id]
ALTER TABLE [dbo].[xf_report] ADD  DEFAULT (N'') FOR [last_modified_username]
ALTER TABLE [dbo].[xf_report] ADD  DEFAULT ((0)) FOR [report_count]
GO
