/****** Object:  Table [dbo].[InventoryLog]    Script Date: 5/15/2018 12:06:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InventoryLog](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[QuantityBilled] [float] NULL,
	[QuantityReceivedOnly] [float] NULL,
	[QuantityOnHand] [float] NULL,
	[QuantityReserved] [float] NULL,
	[QuantityAvailable] [float] NULL,
	[QuantityOnOrder] [float] NULL,
	[QuantityExpected] [float] NULL,
	[UnitCost] [float] NULL,
	[Cost] [float] NULL,
	[PartID] [int] NULL,
	[PartClassTypeID] [int] NULL,
	[InventoryID] [int] NULL,
	[InventoryClassTypeID] [int] NULL,
	[TransDetailID] [int] NULL,
	[TransDetailClassTypeID] [int] NULL,
	[TransPartID] [int] NULL,
	[TransPartClassTypeID] [int] NULL,
	[ProductID] [int] NULL,
	[ProductClassTypeID] [int] NULL,
	[ModifierID] [int] NULL,
	[ModifierClassTypeID] [int] NULL,
	[ActivityLinkID] [int] NULL,
	[ActivityLinkClassTypeID] [int] NULL,
	[ToInventoryID] [int] NULL,
	[ToWarehouseID] [int] NULL,
	[ToDivisionID] [int] NULL,
	[FromWarehouseID] [int] NULL,
	[FromDivisionID] [int] NULL,
	[SortIndex] [int] NULL,
	[UnitID] [int] NULL,
 CONSTRAINT [InventoryLog_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_InventoryLog_ActivityLinkID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_ActivityLinkID] ON [dbo].[InventoryLog]
(
	[ActivityLinkID] ASC,
	[ActivityLinkClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_FromDivisionID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_FromDivisionID] ON [dbo].[InventoryLog]
(
	[FromDivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_FromWarehouseID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_FromWarehouseID] ON [dbo].[InventoryLog]
(
	[FromWarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_InventoryID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_InventoryID] ON [dbo].[InventoryLog]
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_ModifierID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_ModifierID] ON [dbo].[InventoryLog]
(
	[ModifierID] ASC,
	[ModifierClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_PartID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_PartID] ON [dbo].[InventoryLog]
(
	[PartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_ProductID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_ProductID] ON [dbo].[InventoryLog]
(
	[ProductID] ASC,
	[ProductClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_ToDivisoinID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_ToDivisoinID] ON [dbo].[InventoryLog]
(
	[ToDivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_ToInventoryID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_ToInventoryID] ON [dbo].[InventoryLog]
(
	[ToInventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_ToWarehouseID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_ToWarehouseID] ON [dbo].[InventoryLog]
(
	[ToWarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_TransDetailID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_TransDetailID] ON [dbo].[InventoryLog]
(
	[TransDetailID] ASC,
	[TransDetailClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_InventoryLog_TransPartID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_InventoryLog_TransPartID] ON [dbo].[InventoryLog]
(
	[TransPartID] ASC,
	[TransPartClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
