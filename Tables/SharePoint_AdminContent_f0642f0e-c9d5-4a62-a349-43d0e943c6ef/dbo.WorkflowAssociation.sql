/****** Object:  Table [dbo].[WorkflowAssociation]    Script Date: 5/15/2018 12:06:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[WorkflowAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[BaseId] [uniqueidentifier] NOT NULL,
	[ParentId] [varbinary](16) NULL,
	[Name] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Description] [nvarchar](1023) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[StatusFieldName] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[WebId] [varbinary](16) NULL,
	[ListId] [varbinary](16) NULL,
	[ContentTypeId] [dbo].[tContentTypeId] NULL,
	[InstanceCount] [int] NULL,
	[InstanceCountDirty] [bit] NULL,
	[TaskListId] [varbinary](16) NULL,
	[HistoryListId] [varbinary](16) NULL,
	[TaskListTitle] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[HistoryListTitle] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Configuration] [int] NULL,
	[AutoCleanupDays] [int] NULL,
	[Author] [int] NULL,
	[Created] [datetime] NULL,
	[Modified] [datetime] NULL,
	[InstantiationParams] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[PermissionsManual] [dbo].[tPermMask] NULL,
	[Version] [int] NULL,
 CONSTRAINT [WorkflowAssociation_IdUnique] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [WorkflowAssociation_Id]    Script Date: 5/15/2018 12:06:04 PM ******/
CREATE CLUSTERED INDEX [WorkflowAssociation_Id] ON [dbo].[WorkflowAssociation]
(
	[SiteId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [WorkflowAssociation_Parent]    Script Date: 5/15/2018 12:06:04 PM ******/
CREATE NONCLUSTERED INDEX [WorkflowAssociation_Parent] ON [dbo].[WorkflowAssociation]
(
	[SiteId] ASC,
	[WebId] ASC,
	[ListId] ASC,
	[ContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[WorkflowAssociation] ADD  DEFAULT ((0)) FOR [InstanceCount]
ALTER TABLE [dbo].[WorkflowAssociation] ADD  DEFAULT ((0)) FOR [InstanceCountDirty]
GO
