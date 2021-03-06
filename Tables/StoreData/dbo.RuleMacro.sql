/****** Object:  Table [dbo].[RuleMacro]    Script Date: 5/15/2018 12:06:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RuleMacro](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[CategoryType] [int] NULL,
	[AutoTriggerType] [int] NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FilterCondition] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FilterConditionType] [int] NULL,
	[FilterType] [int] NULL,
	[OwnsQuery] [bit] NULL,
	[QueryID] [int] NULL,
	[ParentID] [int] NULL,
	[ParentStoreID] [int] NULL,
	[QueryStoreID] [int] NULL,
	[QueryClassTypeID] [int] NULL,
	[ProceedCondition] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProceedConditionType] [int] NULL,
	[ProceedType] [int] NULL,
	[RuleDataSource] [int] NULL,
	[RuleName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityRightID] [int] NULL,
	[RuleExecuteType] [int] NULL,
	[SQLQuery] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndirectTriggerType] [int] NULL,
	[QueryType] [int] NULL,
	[CreatedByID] [int] NULL,
	[IsPrivate] [bit] NULL,
	[LastModifiedDate] [datetime] NULL,
	[AutoTriggerTargetID] [int] NULL,
	[AutoTriggerTargetClassTypeID] [int] NULL,
	[CanRunManually] [bit] NULL,
 CONSTRAINT [RuleMacro_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_Rule_RuleName]    Script Date: 5/15/2018 12:06:55 PM ******/
CREATE NONCLUSTERED INDEX [Index_Rule_RuleName] ON [dbo].[RuleMacro]
(
	[RuleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_Rule_SecurityRightID]    Script Date: 5/15/2018 12:06:55 PM ******/
CREATE NONCLUSTERED INDEX [Index_Rule_SecurityRightID] ON [dbo].[RuleMacro]
(
	[SecurityRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_Rule]    Script Date: 5/15/2018 12:06:55 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_Rule] ON [dbo].[RuleMacro]
(
	[QueryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_Rule_ParentID]    Script Date: 5/15/2018 12:06:55 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_Rule_ParentID] ON [dbo].[RuleMacro]
(
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
