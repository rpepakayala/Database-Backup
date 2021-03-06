/****** Object:  Table [dbo].[VendorTransDetail]    Script Date: 5/15/2018 12:07:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[VendorTransDetail](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[ItemID] [int] NULL,
	[ItemClassTypeID] [int] NULL,
	[ItemName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DetailType] [int] NULL,
	[Quantity] [float] NULL,
	[UnitPrice] [float] NULL,
	[TotalPrice] [float] NULL,
	[LineItemIndex] [int] NULL,
	[LineItemNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitID] [int] NULL,
	[ExpenseID] [int] NULL,
	[ExpenseClassTypeID] [int] NULL,
	[SKU] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PackingSize] [float] NULL,
	[StageID] [int] NULL,
	[StageClassTypeID] [int] NULL,
	[TransHeaderID] [int] NULL,
	[TransHeaderClassTypeID] [int] NULL,
	[TransHeaderNumber] [int] NULL,
	[VariationID] [int] NULL,
	[UnitText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TransPartID] [int] NULL,
	[TransPartClassTypeID] [int] NULL,
	[POID] [int] NULL,
	[POItemID] [int] NULL,
	[BillID] [int] NULL,
	[BillItemID] [int] NULL,
	[POQuantity] [float] NULL,
	[BillQuantity] [float] NULL,
	[RDQuantity] [float] NULL,
	[RDID] [int] NULL,
	[RDItemID] [int] NULL,
	[StationID] [int] NULL,
	[StationClassTypeID] [int] NULL,
	[RDInventoryType] [int] NULL,
	[BillInventoryType] [int] NULL,
	[BillCostType] [int] NULL,
	[AttachedOrderID] [int] NULL,
	[AttachedOrderClassTypeID] [int] NULL,
	[AttachedOrderIDOV] [bit] NULL,
	[AttachedOrderItemID] [int] NULL,
	[AttachedOrderItemClassTypeID] [int] NULL,
	[AttachedOrderItemIDOV] [bit] NULL,
	[AttachedOrderPartID] [int] NULL,
	[AttachedOrderPartClassTypeID] [int] NULL,
	[AttachedOrderInvID] [int] NULL,
	[AttachedOrderInvClassTypeID] [int] NULL,
	[GLDepartmentID] [int] NULL,
	[GLDepartmentIDOV] [bit] NULL,
	[WarehouseID] [int] NULL,
	[WarehouseIDOV] [bit] NULL,
 CONSTRAINT [VendorTransDetail_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_VendorTransDetail_Station]    Script Date: 5/15/2018 12:07:03 PM ******/
CREATE NONCLUSTERED INDEX [Index_VendorTransDetail_Station] ON [dbo].[VendorTransDetail]
(
	[StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
