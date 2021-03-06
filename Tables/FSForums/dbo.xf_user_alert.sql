/****** Object:  Table [dbo].[xf_user_alert]    Script Date: 5/15/2018 12:00:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_alert](
	[alert_id] [bigint] IDENTITY(39462,1) NOT NULL,
	[alerted_user_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[action] [varbinary](25) NOT NULL,
	[event_date] [bigint] NOT NULL,
	[view_date] [bigint] NOT NULL,
	[extra_data] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_user_alert_alert_id] PRIMARY KEY CLUSTERED 
(
	[alert_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [alertedUserId_eventDate]    Script Date: 5/15/2018 12:00:38 PM ******/
CREATE NONCLUSTERED INDEX [alertedUserId_eventDate] ON [dbo].[xf_user_alert]
(
	[alerted_user_id] ASC,
	[event_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [contentType_contentId]    Script Date: 5/15/2018 12:00:38 PM ******/
CREATE NONCLUSTERED INDEX [contentType_contentId] ON [dbo].[xf_user_alert]
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [viewDate_eventDate]    Script Date: 5/15/2018 12:00:38 PM ******/
CREATE NONCLUSTERED INDEX [viewDate_eventDate] ON [dbo].[xf_user_alert]
(
	[view_date] ASC,
	[event_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_alert] ADD  DEFAULT ((0)) FOR [user_id]
ALTER TABLE [dbo].[xf_user_alert] ADD  DEFAULT (N'') FOR [username]
ALTER TABLE [dbo].[xf_user_alert] ADD  DEFAULT ((0)) FOR [content_id]
ALTER TABLE [dbo].[xf_user_alert] ADD  DEFAULT ((0)) FOR [view_date]
GO
