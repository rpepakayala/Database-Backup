/****** Object:  Table [dbo].[Workflow]    Script Date: 5/15/2018 12:05:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Workflow](
	[Id] [uniqueidentifier] NOT NULL,
	[TemplateId] [uniqueidentifier] NOT NULL,
	[ListId] [uniqueidentifier] NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[TaskListId] [uniqueidentifier] NULL,
	[AdminTaskListId] [varbinary](16) NULL,
	[ItemId] [int] NULL,
	[ItemGUID] [uniqueidentifier] NULL,
	[Author] [int] NULL,
	[Modified] [datetime] NOT NULL,
	[Created] [datetime] NULL,
	[InternalState] [int] NULL,
	[LockMachineId] [uniqueidentifier] NULL,
	[LockMachinePID] [int] NULL,
	[InstanceDataVersion] [int] NOT NULL,
	[InstanceDataSize] [int] NULL,
	[InstanceData] [image] NULL,
	[Modifications] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[HistorySize] [int] NULL,
	[History] [image] NULL,
	[StatusVersion] [int] NOT NULL,
	[Status1] [int] NULL,
	[Status2] [int] NULL,
	[Status3] [int] NULL,
	[Status4] [int] NULL,
	[Status5] [int] NULL,
	[Status6] [int] NULL,
	[Status7] [int] NULL,
	[Status8] [int] NULL,
	[Status9] [int] NULL,
	[Status10] [int] NULL,
	[TextStatus1] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TextStatus2] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TextStatus3] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TextStatus4] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TextStatus5] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [Workflow_PK] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[WebId] ASC,
	[ListId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Workflow_IdUnique] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Workflow_CreatedBy]    Script Date: 5/15/2018 12:05:46 PM ******/
CREATE NONCLUSTERED INDEX [Workflow_CreatedBy] ON [dbo].[Workflow]
(
	[SiteId] ASC,
	[Author] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Workflow_OnId]    Script Date: 5/15/2018 12:05:46 PM ******/
CREATE NONCLUSTERED INDEX [Workflow_OnId] ON [dbo].[Workflow]
(
	[SiteId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Workflow_OnItem]    Script Date: 5/15/2018 12:05:46 PM ******/
CREATE NONCLUSTERED INDEX [Workflow_OnItem] ON [dbo].[Workflow]
(
	[SiteId] ASC,
	[ListId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Workflow] ADD  DEFAULT ((0)) FOR [InstanceDataVersion]
ALTER TABLE [dbo].[Workflow] ADD  DEFAULT ((0)) FOR [StatusVersion]
GO
