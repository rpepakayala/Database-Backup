/****** Object:  Table [dbo].[TransPart]    Script Date: 5/15/2018 12:07:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransPart](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[TransHeaderID] [int] NULL,
	[TransHeaderClassTypeID] [int] NULL,
	[ParentID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[PartID] [int] NULL,
	[PartClassTypeID] [int] NULL,
	[PartCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GoodsItemID] [int] NULL,
	[GoodsItemClassTypeID] [int] NULL,
	[GoodsItemCode] [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Include] [bit] NULL,
	[IncludeCalculated] [bit] NULL,
	[IncludeOverridden] [bit] NULL,
	[CalculatedValue] [float] NULL,
	[EstimatedValue] [float] NULL,
	[EstimatedOverridden] [bit] NULL,
	[ActualValue] [float] NULL,
	[ActualOverridden] [bit] NULL,
	[SortOrder] [int] NULL,
	[UnitID] [int] NULL,
	[UnitsText] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LineItemNumber] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InternalNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartLinkID] [int] NULL,
	[PartLinkClassTypeID] [int] NULL,
	[IsAutomatic] [bit] NULL,
	[ReferenceNumber] [int] NULL,
	[CalculatedCost] [float] NULL,
	[EstimatedCost] [float] NULL,
	[EstimatedCostOverridden] [bit] NULL,
	[ActualCost] [float] NULL,
	[ActualCostOverridden] [bit] NULL,
	[TransDetailID] [int] NULL,
	[TransModID] [int] NULL,
	[ParameterID] [int] NULL,
	[ParameterStoreID] [int] NULL,
	[ParameterClassTypeID] [int] NULL,
	[CostMultiplier] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CostMultiplierType] [int] NULL,
	[TransDetailClassTypeID] [int] NULL,
	[TransModClassTypeID] [int] NULL,
	[IsPart2] [bit] NULL,
	[FixedCostMultiplier] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Vendor] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorPartNumber] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActualPrice] [float] NULL,
	[PartIndex] [float] NULL,
	[VariableID] [int] NULL,
	[VariableStoreID] [int] NULL,
	[VariableClassTypeID] [int] NULL,
	[EstimatedPrice] [float] NULL,
	[StationID] [int] NULL,
	[StationClassTypeID] [int] NULL,
	[StationOverridden] [bit] NULL,
	[IsAttachedToVTrans] [bit] NULL,
	[InventoryID] [int] NULL,
	[InventoryClassTypeID] [int] NULL,
	[ActualPriceOverridden] [bit] NULL,
	[SuggestedPrice] [float] NULL,
	[AttachedPODetailID] [int] NULL,
	[AttachedBillDetailID] [int] NULL,
	[AttachedRDDetailID] [int] NULL,
	[Description] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WarehouseID] [int] NULL,
	[WarehouseIDOV] [bit] NULL,
	[HasReplenishedInventory] [bit] NULL,
	[GLReplenishAdjID] [int] NULL,
	[GLReplenishAdjClassTypeID] [int] NULL,
	[IsReplenishingPart] [bit] NULL,
 CONSTRAINT [TransPart_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_TransPart_GoodsItemID]    Script Date: 5/15/2018 12:07:01 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransPart_GoodsItemID] ON [dbo].[TransPart]
(
	[GoodsItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransPart_ParentID]    Script Date: 5/15/2018 12:07:01 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransPart_ParentID] ON [dbo].[TransPart]
(
	[ParentID] ASC,
	[ParentClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Index_TransPart_PartCode]    Script Date: 5/15/2018 12:07:01 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransPart_PartCode] ON [dbo].[TransPart]
(
	[PartCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransPart_PartID]    Script Date: 5/15/2018 12:07:01 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransPart_PartID] ON [dbo].[TransPart]
(
	[PartID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransPart_TransHeaderID]    Script Date: 5/15/2018 12:07:01 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransPart_TransHeaderID] ON [dbo].[TransPart]
(
	[TransHeaderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransPart_UnitID]    Script Date: 5/15/2018 12:07:01 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransPart_UnitID] ON [dbo].[TransPart]
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
