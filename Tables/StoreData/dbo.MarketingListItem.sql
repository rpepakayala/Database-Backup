/****** Object:  Table [dbo].[MarketingListItem]    Script Date: 5/15/2018 12:06:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MarketingListItem](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[ParentID] [int] NULL,
	[ParentStoreID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[ItemName] [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CanSelect] [bit] NULL,
	[Code1] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Code2] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MarketingListID] [int] NULL,
	[MarketingListStoreID] [int] NULL,
	[MarketingListClassTypeID] [int] NULL,
 CONSTRAINT [MarketingListItem_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_MarketingListItem_ItemName]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_MarketingListItem_ItemName] ON [dbo].[MarketingListItem]
(
	[ItemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_MarketingListItem]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_MarketingListItem] ON [dbo].[MarketingListItem]
(
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_MarketingListItem_MarketingListID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_MarketingListItem_MarketingListID] ON [dbo].[MarketingListItem]
(
	[MarketingListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_MarketingListItem_MarketingListStoreID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_MarketingListItem_MarketingListStoreID] ON [dbo].[MarketingListItem]
(
	[MarketingListStoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_MarketingListItem_ParentStoreID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_MarketingListItem_ParentStoreID] ON [dbo].[MarketingListItem]
(
	[ParentStoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
