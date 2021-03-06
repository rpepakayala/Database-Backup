/****** Object:  Table [dbo].[Order Details Database]    Script Date: 5/15/2018 12:00:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Order Details Database](
	[OrderDetailID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[LineItemNumber] [int] NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[ProductCode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [float] NULL,
	[Sides] [float] NULL,
	[Height] [float] NULL,
	[Width] [float] NULL,
	[ForegroundColor] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BackgroundColor] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Font] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BasePrice] [money] NULL,
	[BasePriceOverriden] [bit] NULL,
	[BasePriceCalculated] [money] NULL,
	[AVTotal] [money] NULL,
	[InstallAmount] [money] NULL,
	[DiscountPercentage] [float] NULL,
	[DiscountAmount] [money] NULL,
	[ItemTotal] [money] NULL,
	[UnitPriceOverridden] [bit] NULL,
	[OverRidden] [bit] NULL,
	[ItemTotalCalculated] [money] NULL,
	[Taxable] [bit] NULL,
	[AllInstallation] [bit] NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AVIDS] [varbinary](100) NULL,
	[AVValues] [varbinary](25) NULL,
	[AVAdditionalAmt] [money] NULL,
	[AVAdditionalDescription] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AVOverridden] [bit] NULL,
	[AVCalculated] [money] NULL,
	[ProductionLocation] [int] NULL,
	[ShopTime] [float] NULL,
	[FieldTime] [float] NULL,
	[FieldCrewSize] [float] NULL,
	[MaterialCost] [money] NULL,
	[HeightAboveGround] [float] NULL,
	[OtherInstallConsideration] [money] NULL,
	[SpecialEquipment1] [bit] NULL,
	[SpecialEquipment2] [bit] NULL,
	[SpecialEquipment3] [bit] NULL,
	[SpecialEquipmentOther] [bit] NULL,
	[SpecialEquipmentOtherAmou] [money] NULL,
	[EstimatedInstallCharge] [money] NULL,
	[AccountCode] [int] NULL,
	[Hidden] [bit] NULL,
	[PMsAnswered] [bit] NULL,
	[ParentItemNumber] [int] NULL,
	[ChildLevel] [int] NULL,
	[BaseCost] [money] NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[ProductionNotes] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HasChildren] [bit] NULL,
	[BaseSonsPrice] [float] NULL,
	[BaseMeAndSonsPrice] [float] NULL,
	[InstallSonsPrice] [float] NULL,
	[InstallMeAndSonsPrice] [float] NULL,
	[DiscountSonsPrice] [float] NULL,
	[DiscountMeAndSonsPrice] [float] NULL,
	[ItemTotalSonsPrice] [float] NULL,
	[ItemTotalMeAndSonsPrice] [float] NULL,
	[ModifierXML] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RoyaltyGroupID] [int] NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Order Details Database] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC,
	[StoreID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Idx_Alex1]    Script Date: 5/15/2018 12:00:53 PM ******/
CREATE NONCLUSTERED INDEX [Idx_Alex1] ON [dbo].[Order Details Database]
(
	[zw_franchise_id] ASC,
	[ProductID] ASC,
	[OrderID] ASC
)
INCLUDE ( 	[OrderDetailID],
	[ItemTotal]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IdX_OrderID_FranchiseID]    Script Date: 5/15/2018 12:00:53 PM ******/
CREATE NONCLUSTERED INDEX [IdX_OrderID_FranchiseID] ON [dbo].[Order Details Database]
(
	[OrderID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Order Details Database] ADD  CONSTRAINT [DF_Order Details Database_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
