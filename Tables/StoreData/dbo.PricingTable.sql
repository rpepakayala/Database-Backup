/****** Object:  Table [dbo].[PricingTable]    Script Date: 5/15/2018 12:06:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PricingTable](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[RowCount] [int] NULL,
	[ColCount] [int] NULL,
	[IsSymmetricTable] [bit] NULL,
	[RowParam1ID] [int] NULL,
	[RowParam1ClassTypeID] [int] NULL,
	[RowParam2ID] [int] NULL,
	[RowParam2ClassTypeID] [int] NULL,
	[ColParamID] [int] NULL,
	[ColParamClassTypeID] [int] NULL,
	[OnRowNotFound] [int] NULL,
	[OnRowOutOfBounds] [int] NULL,
	[OnColNotFound] [int] NULL,
	[TableElementStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PricingTableName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CategoryID] [int] NULL,
	[CategoryStoreID] [int] NULL,
	[CategoryClassTypeID] [int] NULL,
	[Row1UnitID] [int] NULL,
	[Row2UnitID] [int] NULL,
	[ColUnitID] [int] NULL,
	[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PricingTable_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_PricingTable_ColParamID]    Script Date: 5/15/2018 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [Index_PricingTable_ColParamID] ON [dbo].[PricingTable]
(
	[ColParamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_PricingTable_RowParam2ID]    Script Date: 5/15/2018 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [Index_PricingTable_RowParam2ID] ON [dbo].[PricingTable]
(
	[RowParam2ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_PricingTable]    Script Date: 5/15/2018 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_PricingTable] ON [dbo].[PricingTable]
(
	[RowParam1ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
