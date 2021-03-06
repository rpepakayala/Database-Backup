/****** Object:  Table [Staging].[OrderDetails]    Script Date: 5/15/2018 11:59:57 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Staging].[OrderDetails](
	[WebNumber]  AS (case when ascii(substring([ZW_FRANCHISE_ID],(4),(1)))<(58) then CONVERT([smallint],right([ZW_FRANCHISE_ID],(4)),(0)) else CONVERT([smallint],(-1),(0)) end),
	[OrderID] [int] NULL,
	[StoreID] [int] NULL,
	[OrderDetailID] [int] NULL,
	[LineItemNumber] [int] NULL,
	[ProductID] [int] NULL,
	[ProductCode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [float] NULL,
	[BasePrice] [money] NULL,
	[BasePriceOverriden] [bit] NULL,
	[BasePriceCalculated] [money] NULL,
	[AVTotal] [money] NULL,
	[InstallAmount] [money] NULL,
	[DiscountPercentage] [float] NULL,
	[ItemTotal] [money] NULL,
	[UnitPriceOverridden] [bit] NULL,
	[OverRidden] [bit] NULL,
	[ItemTotalCalculated] [money] NULL,
	[Taxable] [bit] NULL,
	[ShopTime] [float] NULL,
	[FieldTime] [float] NULL,
	[FieldCrewSize] [float] NULL,
	[MaterialCost] [money] NULL,
	[AccountCode] [int] NULL,
	[BaseCost] [money] NULL,
	[Height] [real] NULL,
	[Weight] [real] NULL,
	[Description] [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignText] [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ZW_Franchise_ID] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiscountAmount] [money] NULL,
	[sys_di] [datetime] NULL,
	[sys_du] [datetime] NULL,
	[SequenceID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[SequenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
