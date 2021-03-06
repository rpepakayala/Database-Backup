/****** Object:  Table [dbo].[AllLists]    Script Date: 5/15/2018 12:05:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AllLists](
	[tp_WebId] [uniqueidentifier] NOT NULL,
	[tp_ID] [uniqueidentifier] NOT NULL,
	[tp_Title] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_Created] [datetime] NOT NULL,
	[tp_Modified] [datetime] NOT NULL,
	[tp_LastDeleted] [datetime] NOT NULL,
	[tp_DeleteCount] [int] NOT NULL,
	[tp_LastSecurityChange] [datetime] NOT NULL,
	[tp_Version] [int] NOT NULL,
	[tp_Author] [int] NULL,
	[tp_BaseType] [int] NOT NULL,
	[tp_FeatureId] [uniqueidentifier] NULL,
	[tp_ServerTemplate] [int] NOT NULL,
	[tp_RootFolder] [uniqueidentifier] NOT NULL,
	[tp_Template] [uniqueidentifier] NULL,
	[tp_ImageUrl] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_ReadSecurity] [int] NOT NULL,
	[tp_WriteSecurity] [int] NOT NULL,
	[tp_Subscribed] [bit] NOT NULL,
	[tp_Direction] [int] NULL,
	[tp_Flags] [bigint] NOT NULL,
	[tp_ThumbnailSize] [int] NULL,
	[tp_WebImageWidth] [int] NULL,
	[tp_WebImageHeight] [int] NULL,
	[tp_ItemCount] [int] NOT NULL,
	[tp_NextAvailableId] [int] NOT NULL,
	[tp_Description] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_EmailInsertsFolder] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_EmailInsertsLastSyncTime] [nvarchar](50) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_EmailAlias] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_DeleteTransactionId] [varbinary](16) NOT NULL,
	[tp_ScopeId] [uniqueidentifier] NOT NULL,
	[tp_HasFGP] [bit] NOT NULL,
	[tp_HasInternalFGP] [bit] NOT NULL,
	[tp_EventSinkAssembly] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_EventSinkClass] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_EventSinkData] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_MaxRowOrdinal] [int] NOT NULL,
	[tp_Fields] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_ContentTypes] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_AuditFlags] [int] NULL,
	[tp_InheritAuditFlags] [int] NULL,
	[tp_SendToLocation] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_ListDataDirty] [int] NOT NULL,
	[tp_CacheParseId] [uniqueidentifier] NULL,
	[tp_MaxMajorVersionCount] [int] NULL,
	[tp_MaxMajorwithMinorVersionCount] [int] NULL,
	[tp_DefaultWorkflowId] [uniqueidentifier] NULL,
 CONSTRAINT [AllLists_PK] PRIMARY KEY CLUSTERED 
(
	[tp_WebId] ASC,
	[tp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Lists_FullText]    Script Date: 5/15/2018 12:05:49 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Lists_FullText] ON [dbo].[AllLists]
(
	[tp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT ((0)) FOR [tp_DeleteCount]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT (getutcdate()) FOR [tp_LastSecurityChange]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT ((0)) FOR [tp_Subscribed]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT (0x) FOR [tp_DeleteTransactionId]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT ((0)) FOR [tp_HasFGP]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT ((0)) FOR [tp_HasInternalFGP]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT ((0)) FOR [tp_MaxRowOrdinal]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT ((0)) FOR [tp_ListDataDirty]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT (NULL) FOR [tp_CacheParseId]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT (NULL) FOR [tp_MaxMajorVersionCount]
ALTER TABLE [dbo].[AllLists] ADD  DEFAULT (NULL) FOR [tp_MaxMajorwithMinorVersionCount]
GO
