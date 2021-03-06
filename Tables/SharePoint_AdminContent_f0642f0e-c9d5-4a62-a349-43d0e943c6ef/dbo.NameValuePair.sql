/****** Object:  Table [dbo].[NameValuePair]    Script Date: 5/15/2018 12:05:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[NameValuePair](
	[SiteId] [uniqueidentifier] NOT NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[ListId] [uniqueidentifier] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[FieldId] [uniqueidentifier] NOT NULL,
	[Value] [sql_variant] NULL
) ON [PRIMARY]

/****** Object:  Index [NameValuePair_CI]    Script Date: 5/15/2018 12:05:53 PM ******/
CREATE CLUSTERED INDEX [NameValuePair_CI] ON [dbo].[NameValuePair]
(
	[SiteId] ASC,
	[ListId] ASC,
	[FieldId] ASC,
	[Value] ASC,
	[ItemId] ASC,
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [NameValuePair_MatchUserData]    Script Date: 5/15/2018 12:05:53 PM ******/
CREATE NONCLUSTERED INDEX [NameValuePair_MatchUserData] ON [dbo].[NameValuePair]
(
	[SiteId] ASC,
	[ListId] ASC,
	[ItemId] ASC,
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [NameValuePair_NoListId]    Script Date: 5/15/2018 12:05:53 PM ******/
CREATE NONCLUSTERED INDEX [NameValuePair_NoListId] ON [dbo].[NameValuePair]
(
	[SiteId] ASC,
	[FieldId] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[NameValuePair] ADD  DEFAULT ((1)) FOR [Level]
GO
