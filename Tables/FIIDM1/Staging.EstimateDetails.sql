/****** Object:  Table [Staging].[EstimateDetails]    Script Date: 5/15/2018 11:59:56 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Staging].[EstimateDetails](
	[WebNumber]  AS (case when ascii(substring([ZW_FRANCHISE_ID],(4),(1)))<(58) then CONVERT([smallint],right([ZW_FRANCHISE_ID],(4)),(0)) else CONVERT([smallint],(-1),(0)) end),
	[OrderID] [int] NULL,
	[StoreID] [int] NULL,
	[DiscountAmount] [float] NULL,
	[sys_di] [datetime] NULL,
	[sys_du] [datetime] NULL,
	[OrderDetailID] [int] NULL,
	[LineItemNumber] [int] NULL,
	[ProductID] [int] NULL,
	[ProductCode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [float] NULL,
	[BasePrice] [float] NULL,
	[BasePriceOverriden] [bit] NULL,
	[BasePriceCalculated] [float] NULL,
	[AVTotal] [float] NULL,
	[InstallAmount] [float] NULL,
	[DiscountPercentage] [float] NULL,
	[ItemTotal] [float] NULL,
	[UnitPriceOverridden] [bit] NULL,
	[OverRidden] [bit] NULL,
	[ItemTotalCalculated] [float] NULL,
	[Taxable] [bit] NULL,
	[ShopTime] [float] NULL,
	[FieldTime] [float] NULL,
	[FieldCrewSize] [float] NULL,
	[MaterialCost] [float] NULL,
	[AccountCode] [int] NULL,
	[BaseCost] [float] NULL,
	[ZW_Franchise_ID] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Height] [float] NULL,
	[Width] [float] NULL,
	[Description] [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignText] [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SequenceID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
