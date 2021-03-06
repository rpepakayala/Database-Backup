/****** Object:  Table [dbo].[Order Database]    Script Date: 5/15/2018 12:00:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Order Database](
	[OrderID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[PricingRatio] [float] NULL,
	[Description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NumberItems] [int] NULL,
	[CustomerID] [int] NULL,
	[ContactID] [int] NULL,
	[OrdererFirstName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererLastName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererTitle] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererPareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererPhoneNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererPhoneExtention] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererFareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererFaxNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdererEmailAddress] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SalePersonID] [int] NULL,
	[EnteredByID] [int] NULL,
	[Status] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OnHold] [bit] NULL,
	[EstimateDate] [datetime] NULL,
	[OrderDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[DueTime] [datetime] NULL,
	[BuiltDate] [datetime] NULL,
	[VoidDate] [datetime] NULL,
	[PickedUpDate] [datetime] NULL,
	[WriteoffDate] [datetime] NULL,
	[HoldDate] [datetime] NULL,
	[LastInterestDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL,
	[SignSales] [money] NULL,
	[AVISales] [money] NULL,
	[InstallSales] [money] NULL,
	[ProductionCat1Sales] [money] NULL,
	[ProductionCat2Sales] [money] NULL,
	[ProductionCat3Sales] [money] NULL,
	[ItemsTotal] [money] NULL,
	[SalesSubtotal] [money] NULL,
	[TaxableAmount] [money] NULL,
	[TaxExemptAmount] [money] NULL,
	[TaxExemptAmountCalculated] [money] NULL,
	[TaxExemptAmountOverridden] [bit] NULL,
	[TaxExempt] [bit] NULL,
	[TaxIDNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxRegionID] [int] NULL,
	[CountySalesTax] [money] NULL,
	[CountySalesTaxRate] [float] NULL,
	[StateSalesTax] [money] NULL,
	[StateSalesTaxRate] [float] NULL,
	[TaxTotal] [money] NULL,
	[PromotionID] [int] NULL,
	[DiscountAmount] [money] NULL,
	[DiscountPercent] [float] NULL,
	[ShippingCharge] [money] NULL,
	[InterestAmount] [money] NULL,
	[SalesTotal] [money] NULL,
	[TotalPayments] [money] NULL,
	[BalanceOutstanding] [money] NULL,
	[WriteoffAmount] [money] NULL,
	[PurchaseOrderNumber] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingAddress] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DispositionOnCompletion] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InstallNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EstimateNumber] [int] NULL,
	[ItemsDiscountTotal] [money] NULL,
	[DiscountTotal] [money] NULL,
	[DispositionOnCompletionID] [int] NULL,
	[CustomerName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingTaxable] [bit] NULL,
	[RoyaltyRate] [float] NULL,
	[JobBox] [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProofDate] [datetime] NULL,
	[LineItemsOverriden] [bit] NULL,
	[OrderOriginID] [int] NULL,
	[IsLocked] [bit] NULL,
	[LockedDate] [datetime] NULL,
	[LockedUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NULL,
	[EstGreetingIntro] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EstGreetingIntroOV] [bit] NULL,
	[EstGreetingBody] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EstGreetingClosing] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EstGreetingClosingOV] [bit] NULL,
	[ConvertedDate] [datetime] NULL,
	[ConvertedOrderID] [int] NULL,
	[LostDate] [datetime] NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Order Database] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[StoreID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_PickedUpDate_inc_SalesSubtotal_zw_franchise_id]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [Hint_PickedUpDate_inc_SalesSubtotal_zw_franchise_id] ON [dbo].[Order Database]
(
	[PickedUpDate] ASC
)
INCLUDE ( 	[SalesSubtotal],
	[zw_franchise_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_zw_franchise_id]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [Hint_zw_franchise_id] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC
)
INCLUDE ( 	[sys_du]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Idx_Alex5]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [Idx_Alex5] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC,
	[PickedUpDate] ASC,
	[OrderID] ASC,
	[CustomerID] ASC
)
INCLUDE ( 	[ItemsTotal],
	[DiscountAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Idx_FranchiseID_OrderDate_OrderID_CustomerID]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [Idx_FranchiseID_OrderDate_OrderID_CustomerID] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC,
	[OrderDate] ASC,
	[OrderID] ASC,
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_OrderDB_FranchiseID]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [IDX_OrderDB_FranchiseID] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC
)
INCLUDE ( 	[OrderDate],
	[PickedUpDate],
	[ClosedDate],
	[SalesSubtotal]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_ORDERDB_OrderDate]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [IDX_ORDERDB_OrderDate] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC,
	[OrderDate] ASC
)
INCLUDE ( 	[OrderID],
	[CustomerID],
	[SalesSubtotal]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_OrderDB_Status]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [IDX_OrderDB_Status] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC,
	[Status] ASC
)
INCLUDE ( 	[CustomerID],
	[OrderDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [NCIDX_OrderDatabase_multiple1]    Script Date: 5/15/2018 12:00:52 PM ******/
CREATE NONCLUSTERED INDEX [NCIDX_OrderDatabase_multiple1] ON [dbo].[Order Database]
(
	[zw_franchise_id] ASC,
	[Status] ASC,
	[BalanceOutstanding] ASC,
	[StoreID] ASC,
	[OrderID] ASC,
	[PickedUpDate] ASC,
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
