/****** Object:  Table [dbo].[UserInfo]    Script Date: 5/15/2018 12:06:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[UserInfo](
	[tp_SiteID] [uniqueidentifier] NOT NULL,
	[tp_ID] [int] NOT NULL,
	[tp_DomainGroup] [bit] NOT NULL,
	[tp_GUID] [uniqueidentifier] NOT NULL,
	[tp_SystemID] [dbo].[tSystemID] NOT NULL,
	[tp_Deleted] [int] NOT NULL,
	[tp_SiteAdmin] [bit] NOT NULL,
	[tp_IsActive] [bit] NOT NULL,
	[tp_Login] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_Title] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_Email] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_Notes] [nvarchar](1023) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_Token] [image] NULL,
	[tp_ExternalToken] [image] NULL,
	[tp_ExternalTokenLastUpdated] [datetime] NULL,
	[tp_Locale] [int] NULL,
	[tp_CalendarType] [smallint] NULL,
	[tp_AdjustHijriDays] [smallint] NULL,
	[tp_TimeZone] [smallint] NULL,
	[tp_Time24] [bit] NULL,
	[tp_AltCalendarType] [tinyint] NULL,
	[tp_CalendarViewOptions] [tinyint] NULL,
	[tp_WorkDays] [smallint] NULL,
	[tp_WorkDayStartHour] [smallint] NULL,
	[tp_WorkDayEndHour] [smallint] NULL,
 CONSTRAINT [UserInfo_PK] PRIMARY KEY CLUSTERED 
(
	[tp_SiteID] ASC,
	[tp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [UserInfo_Email]    Script Date: 5/15/2018 12:06:02 PM ******/
CREATE NONCLUSTERED INDEX [UserInfo_Email] ON [dbo].[UserInfo]
(
	[tp_SiteID] ASC,
	[tp_Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [UserInfo_Login]    Script Date: 5/15/2018 12:06:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserInfo_Login] ON [dbo].[UserInfo]
(
	[tp_SiteID] ASC,
	[tp_Login] ASC,
	[tp_Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [UserInfo_SID]    Script Date: 5/15/2018 12:06:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserInfo_SID] ON [dbo].[UserInfo]
(
	[tp_SiteID] ASC,
	[tp_SystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [UserInfo_SiteAdmin]    Script Date: 5/15/2018 12:06:02 PM ******/
CREATE NONCLUSTERED INDEX [UserInfo_SiteAdmin] ON [dbo].[UserInfo]
(
	[tp_SiteID] ASC,
	[tp_SiteAdmin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[UserInfo] ADD  DEFAULT (newid()) FOR [tp_GUID]
ALTER TABLE [dbo].[UserInfo] ADD  DEFAULT ((1)) FOR [tp_IsActive]
GO
