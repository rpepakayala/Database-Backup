/****** Object:  Table [dbo].[SchedSubscriptions]    Script Date: 5/15/2018 12:05:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SchedSubscriptions](
	[Id] [uniqueidentifier] NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[NotifyFreq] [int] NOT NULL,
	[NotifyTime] [datetime] NULL,
	[NotifyTimeUTC] [datetime] NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[ListId] [uniqueidentifier] NOT NULL,
	[ItemId] [int] NULL,
	[EventType] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[UserEmail] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[SiteUrl] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[WebUrl] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[WebTitle] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[WebLanguage] [int] NOT NULL,
	[WebLocale] [int] NOT NULL,
	[WebTimeZone] [smallint] NOT NULL,
	[WebTime24] [bit] NULL,
	[WebCalendarType] [smallint] NULL,
	[WebAdjustHijriDays] [smallint] NULL,
	[ListUrl] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[ListTitle] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[ListBaseType] [int] NOT NULL,
	[ListServerTemplate] [int] NOT NULL,
	[AlertTitle] [nvarchar](1000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[AlertType] [int] NULL,
	[AlertTemplateName] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Filter] [nvarchar](4000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[BinaryFilter] [varbinary](1024) NULL,
	[Properties] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Status] [tinyint] NOT NULL,
	[ItemDocId] [uniqueidentifier] NULL,
	[Deleted] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [SchedSubscriptions_SiteIdNotifyFreqListIdItemId]    Script Date: 5/15/2018 12:05:43 PM ******/
CREATE CLUSTERED INDEX [SchedSubscriptions_SiteIdNotifyFreqListIdItemId] ON [dbo].[SchedSubscriptions]
(
	[SiteId] ASC,
	[NotifyFreq] ASC,
	[ListId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [SchedSubscriptions_NotifyTimeUTC]    Script Date: 5/15/2018 12:05:43 PM ******/
CREATE NONCLUSTERED INDEX [SchedSubscriptions_NotifyTimeUTC] ON [dbo].[SchedSubscriptions]
(
	[NotifyTimeUTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [SchedSubscriptions_SiteIdUserIdSubId]    Script Date: 5/15/2018 12:05:43 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [SchedSubscriptions_SiteIdUserIdSubId] ON [dbo].[SchedSubscriptions]
(
	[SiteId] ASC,
	[UserId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [SchedSubscriptions_SiteIdWebIdUserId]    Script Date: 5/15/2018 12:05:43 PM ******/
CREATE NONCLUSTERED INDEX [SchedSubscriptions_SiteIdWebIdUserId] ON [dbo].[SchedSubscriptions]
(
	[SiteId] ASC,
	[WebId] ASC,
	[UserId] ASC,
	[AlertType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [SchedSubscriptions_SiteIdWebUrlListUrl]    Script Date: 5/15/2018 12:05:43 PM ******/
CREATE NONCLUSTERED INDEX [SchedSubscriptions_SiteIdWebUrlListUrl] ON [dbo].[SchedSubscriptions]
(
	[SiteId] ASC,
	[WebUrl] ASC,
	[ListUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[SchedSubscriptions] ADD  DEFAULT ((0)) FOR [WebTime24]
ALTER TABLE [dbo].[SchedSubscriptions] ADD  DEFAULT ((1)) FOR [WebCalendarType]
ALTER TABLE [dbo].[SchedSubscriptions] ADD  DEFAULT ((0)) FOR [Status]
ALTER TABLE [dbo].[SchedSubscriptions] ADD  DEFAULT ((0)) FOR [Deleted]
GO
