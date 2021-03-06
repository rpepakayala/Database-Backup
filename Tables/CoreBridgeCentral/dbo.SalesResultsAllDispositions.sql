/****** Object:  Table [dbo].[SalesResultsAllDispositions]    Script Date: 5/15/2018 11:59:04 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SalesResultsAllDispositions](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FranchiseName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IncomeTypeId] [int] NULL,
	[IncomeTypeDescription] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IncomeTypeText] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortAccount] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationId] [int] NULL,
	[LocationName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InvoiceNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderActive] [bit] NULL,
	[OrderStatusId] [int] NULL,
	[OrderCompletionDate] [datetimeoffset](7) NULL,
	[OrderClosedDate] [datetimeoffset](7) NULL,
	[OrderBuiltDate] [datetimeoffset](7) NULL,
	[OrderCreatedDate] [datetimeoffset](7) NULL,
	[OrderVoidedDate] [datetimeoffset](7) NULL,
	[CategoryId] [int] NULL,
	[ProductCategory] [varchar](127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndustryType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SalesPersonName] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GLAcctId] [int] NULL,
	[GL_Account] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CostOfGoodsSold] [decimal](18, 6) NULL,
	[AdditionalCosts] [decimal](18, 6) NULL,
	[Amount] [decimal](18, 6) NULL,
	[SubTotalPrice] [decimal](18, 6) NULL,
	[DiscountPrice] [decimal](18, 6) NULL,
	[TaxesPrice] [decimal](18, 6) NULL,
	[ShippingAmount] [decimal](18, 6) NULL,
	[PostageAmount] [decimal](18, 6) NULL,
	[TaxableAmount] [decimal](18, 6) NULL,
	[NonTaxableAmount] [decimal](18, 6) NULL,
	[BalanceDue] [money] NULL,
	[Currency] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Id] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[OrderProductId] [int] NOT NULL,
	[OrderProductPartId] [int] NOT NULL,
	[OrderProductLineItem] [int] NOT NULL,
	[MaxProductLineItem] [int] NULL,
	[IsVended] [bit] NULL,
	[OrderContactName] [varchar](127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingAddress1] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingAddress2] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingAddress3] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingCity] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingState] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingCounty] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingZip] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillngZipExtended] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingAddress1] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingAddress2] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingAddress3] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingCity] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingState] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingCounty] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingZip] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingZipExtended] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
	[CorebridgeOrder]  AS (CONVERT([varchar](20),[dbo].[CorebridgeOrderFromInvoice]([InvoiceNumber]))) PERSISTED,
	[ChildGLAcctId] [int] NULL,
	[ChildGL_Account] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_SalesResultsAllDispositions] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_Amount_inc]    Script Date: 5/15/2018 11:59:04 AM ******/
CREATE NONCLUSTERED INDEX [Hint_Amount_inc] ON [dbo].[SalesResultsAllDispositions]
(
	[Amount] ASC
)
INCLUDE ( 	[CompanyLocationId],
	[IncomeTypeDescription],
	[IncomeTypeText],
	[OrderCompletionDate],
	[OrderClosedDate],
	[ProductCategory],
	[GL_Account],
	[OrderId],
	[OLTP_InsertDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_CompanyLocationId_OrderCompletionDate]    Script Date: 5/15/2018 11:59:04 AM ******/
CREATE NONCLUSTERED INDEX [Hint_CompanyLocationId_OrderCompletionDate] ON [dbo].[SalesResultsAllDispositions]
(
	[CompanyLocationId] ASC,
	[OrderCompletionDate] ASC
)
INCLUDE ( 	[OrderClosedDate],
	[ProductCategory],
	[GL_Account],
	[Amount],
	[OrderId],
	[OLTP_InsertDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_SalesResultsAllDispositions_OrderCompletionDate]    Script Date: 5/15/2018 11:59:04 AM ******/
CREATE NONCLUSTERED INDEX [Hint_SalesResultsAllDispositions_OrderCompletionDate] ON [dbo].[SalesResultsAllDispositions]
(
	[OrderCompletionDate] ASC
)
INCLUDE ( 	[CompanyLocationId],
	[IndustryType],
	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [SalesResultsAllDispositions_CompanyLocationId_OrderCompletionDate]    Script Date: 5/15/2018 11:59:04 AM ******/
CREATE NONCLUSTERED INDEX [SalesResultsAllDispositions_CompanyLocationId_OrderCompletionDate] ON [dbo].[SalesResultsAllDispositions]
(
	[CompanyLocationId] ASC,
	[OrderCompletionDate] ASC
)
INCLUDE ( 	[FranchiseName],
	[LocationId],
	[LocationName],
	[InvoiceNumber],
	[ShippingZipExtended],
	[ShippingAddress2],
	[ShippingAddress3],
	[ShippingCity],
	[ShippingState],
	[ShippingCounty],
	[ShippingZip],
	[BillingCity],
	[BillingState],
	[BillingCounty],
	[BillingZip],
	[BillngZipExtended],
	[ShippingAddress1],
	[SalesPersonName],
	[OrderId],
	[OrderContactName],
	[BillingAddress1],
	[BillingAddress2],
	[BillingAddress3],
	[OrderActive],
	[OrderBuiltDate],
	[OrderCreatedDate],
	[CompanyName],
	[IndustryType],
	[CustomerType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [SalesResultsAllDispositions_InvoiceNumber]    Script Date: 5/15/2018 11:59:04 AM ******/
CREATE NONCLUSTERED INDEX [SalesResultsAllDispositions_InvoiceNumber] ON [dbo].[SalesResultsAllDispositions]
(
	[InvoiceNumber] ASC
)
INCLUDE ( 	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [SalesResultsAllDispositions_OrderCompletionDate]    Script Date: 5/15/2018 11:59:04 AM ******/
CREATE NONCLUSTERED INDEX [SalesResultsAllDispositions_OrderCompletionDate] ON [dbo].[SalesResultsAllDispositions]
(
	[OrderCompletionDate] ASC
)
INCLUDE ( 	[CompanyLocationId],
	[FranchiseName],
	[LocationId],
	[LocationName],
	[InvoiceNumber],
	[ShippingZipExtended],
	[ShippingAddress2],
	[ShippingAddress3],
	[ShippingCity],
	[ShippingState],
	[ShippingCounty],
	[ShippingZip],
	[BillingCity],
	[BillingState],
	[BillingCounty],
	[BillingZip],
	[BillngZipExtended],
	[ShippingAddress1],
	[SalesPersonName],
	[OrderId],
	[OrderContactName],
	[BillingAddress1],
	[BillingAddress2],
	[BillingAddress3],
	[OrderActive],
	[OrderBuiltDate],
	[OrderCreatedDate],
	[CompanyName],
	[IndustryType],
	[CustomerType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[SalesResultsAllDispositions] ADD  CONSTRAINT [DF_SalesResultsAllDispositions_OLTP_InsertDate]  DEFAULT (getdate()) FOR [OLTP_InsertDate]
GO
