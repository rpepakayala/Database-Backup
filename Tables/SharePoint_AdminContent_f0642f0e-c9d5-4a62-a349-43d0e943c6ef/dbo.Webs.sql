/****** Object:  Table [dbo].[Webs]    Script Date: 5/15/2018 12:06:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Webs](
	[Id] [uniqueidentifier] NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[FullUrl] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[ParentWebId] [uniqueidentifier] NULL,
	[ProductVersion] [smallint] NOT NULL,
	[TemplateVersion] [smallint] NOT NULL,
	[FirstUniqueAncestorWebId] [uniqueidentifier] NOT NULL,
	[Author] [int] NOT NULL,
	[Title] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TimeCreated] [datetime] NOT NULL,
	[CachedNavDirty] [int] NOT NULL,
	[CachedNav] [image] NULL,
	[CachedInheritedNav] [image] NULL,
	[CachedNavScope] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CachedDataVersion] [int] NOT NULL,
	[Description] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[ScopeId] [uniqueidentifier] NOT NULL,
	[SecurityProvider] [uniqueidentifier] NULL,
	[MetaInfo] [image] NULL,
	[MetaInfoVersion] [int] NOT NULL,
	[LastMetadataChange] [datetime] NOT NULL,
	[NavStructNextEid] [int] NOT NULL,
	[NavParentWebId] [uniqueidentifier] NULL,
	[NextWebGroupId] [int] NOT NULL,
	[DefTheme] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[AlternateCSSUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CustomizedCss] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CustomJSUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[AlternateHeaderUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[DailyUsageData] [image] NULL,
	[DailyUsageDataVersion] [int] NOT NULL,
	[MonthlyUsageData] [image] NULL,
	[MonthlyUsageDataVersion] [int] NOT NULL,
	[DayLastAccessed] [smallint] NOT NULL,
	[WebTemplate] [int] NOT NULL,
	[Language] [int] NOT NULL,
	[Locale] [int] NOT NULL,
	[TimeZone] [smallint] NOT NULL,
	[Time24] [bit] NULL,
	[CalendarType] [smallint] NULL,
	[AdjustHijriDays] [smallint] NULL,
	[MeetingCount] [smallint] NOT NULL,
	[ProvisionConfig] [smallint] NOT NULL,
	[Flags] [int] NOT NULL,
	[Collation] [smallint] NOT NULL,
	[RequestAccessEmail] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[MasterUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CustomMasterUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[SiteLogoUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[SiteLogoDescription] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[AuditFlags] [int] NULL,
	[InheritAuditFlags] [int] NULL,
	[Ancestry] [image] NULL,
	[AltCalendarType] [tinyint] NULL,
	[CalendarViewOptions] [tinyint] NULL,
	[WorkDays] [smallint] NULL,
	[WorkDayStartHour] [smallint] NULL,
	[WorkDayEndHour] [smallint] NULL,
	[EmailEnabled] [bit] NOT NULL,
 CONSTRAINT [Webs_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Webs_CMU]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [Webs_CMU] ON [dbo].[Webs]
(
	[SiteId] ASC,
	[CustomMasterUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Webs_FUAWI]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [Webs_FUAWI] ON [dbo].[Webs]
(
	[FirstUniqueAncestorWebId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Webs_MU]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [Webs_MU] ON [dbo].[Webs]
(
	[SiteId] ASC,
	[MasterUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Webs_NPWI]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [Webs_NPWI] ON [dbo].[Webs]
(
	[NavParentWebId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Webs_SiteIdParent]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [Webs_SiteIdParent] ON [dbo].[Webs]
(
	[SiteId] ASC,
	[ParentWebId] ASC,
	[FullUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Webs] ADD  CONSTRAINT [DEFAULT_CachedNavDirty]  DEFAULT ((131071)) FOR [CachedNavDirty]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT ((0)) FOR [CachedDataVersion]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT (getutcdate()) FOR [LastMetadataChange]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT ((0)) FOR [Time24]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT ((1)) FOR [CalendarType]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT ((0)) FOR [MeetingCount]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT (((((0)|0x01)|0x02)|0x20)|0x0100) FOR [Flags]
ALTER TABLE [dbo].[Webs] ADD  DEFAULT ((0)) FOR [EmailEnabled]
GO
