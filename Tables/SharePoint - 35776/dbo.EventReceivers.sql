/****** Object:  Table [dbo].[EventReceivers]    Script Date: 5/15/2018 12:05:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[EventReceivers](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[HostType] [int] NOT NULL,
	[ItemId] [int] NULL,
	[DirName] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[LeafName] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Type] [int] NOT NULL,
	[SequenceNumber] [int] NOT NULL,
	[Assembly] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Class] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Data] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Filter] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[SourceId] [dbo].[tContentTypeId] NULL,
	[SourceType] [int] NOT NULL,
	[Credential] [int] NOT NULL,
	[ContextType] [varbinary](16) NULL,
	[ContextEventType] [varbinary](16) NULL,
	[ContextId] [varbinary](16) NULL,
	[ContextObjectId] [varbinary](16) NULL,
	[ContextCollectionId] [varbinary](16) NULL,
 CONSTRAINT [EventReceivers_IdUnique] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [EventReceivers_ByTarget]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE UNIQUE CLUSTERED INDEX [EventReceivers_ByTarget] ON [dbo].[EventReceivers]
(
	[SiteId] ASC,
	[WebId] ASC,
	[HostId] ASC,
	[HostType] ASC,
	[Type] ASC,
	[ContextCollectionId] ASC,
	[ContextObjectId] ASC,
	[ContextId] ASC,
	[ContextType] ASC,
	[ContextEventType] ASC,
	[SequenceNumber] ASC,
	[Assembly] ASC,
	[Class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [EventReceivers_ByContextCollectionId]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE NONCLUSTERED INDEX [EventReceivers_ByContextCollectionId] ON [dbo].[EventReceivers]
(
	[SiteId] ASC,
	[ContextCollectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [EventReceivers_ByContextObjectId]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE NONCLUSTERED INDEX [EventReceivers_ByContextObjectId] ON [dbo].[EventReceivers]
(
	[SiteId] ASC,
	[ContextObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [EventReceivers_ById]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [EventReceivers_ById] ON [dbo].[EventReceivers]
(
	[SiteId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[EventReceivers] ADD  DEFAULT ((0)) FOR [SourceType]
ALTER TABLE [dbo].[EventReceivers] ADD  DEFAULT ((0)) FOR [Credential]
GO
