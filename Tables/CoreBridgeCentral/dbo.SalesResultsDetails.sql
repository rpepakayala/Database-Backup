/****** Object:  Table [dbo].[SalesResultsDetails]    Script Date: 5/15/2018 11:59:05 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SalesResultsDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FranchiseName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationId] [int] NULL,
	[LocationName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderId] [int] NULL,
	[OrderActive] [int] NULL,
	[OrderStatusId] [int] NULL,
	[InvoiceNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderCompletionDate] [datetimeoffset](7) NULL,
	[OrderClosedDate] [datetimeoffset](7) NULL,
	[OrderBuiltDate] [datetimeoffset](7) NULL,
	[OrderCreatedDate] [datetimeoffset](7) NULL,
	[OrderVoidedDate] [datetimeoffset](7) NULL,
	[AccountId] [int] NULL,
	[CompanyName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndustryType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReferredByTypeId] [int] NULL,
	[CustomerOrigin] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SalesPersonId] [int] NULL,
	[SalesPersonName] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EnteredByUserId] [int] NULL,
	[CostOfGoodsSold] [decimal](18, 6) NULL,
	[AdditionalCosts] [decimal](18, 6) NULL,
	[Amount] [decimal](18, 6) NULL,
	[BalanceDue] [money] NULL,
	[Currency] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NewSubtotal] [decimal](18, 6) NULL,
	[ShippingAmount] [decimal](18, 6) NULL,
	[PostageAmount] [decimal](18, 6) NULL,
	[TaxesPrice] [decimal](18, 6) NULL,
	[MasterAccountId] [int] NULL,
	[MasterAccountName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MasterAccountSortName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
 CONSTRAINT [PK_SalesResultsDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_SalesResultsDetails_CompanyLocationId_OrderId]    Script Date: 5/15/2018 11:59:05 AM ******/
CREATE NONCLUSTERED INDEX [Hint_SalesResultsDetails_CompanyLocationId_OrderId] ON [dbo].[SalesResultsDetails]
(
	[CompanyLocationId] ASC,
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_SalesResultsDetails_OrderStatusId_OrderCompletionDate]    Script Date: 5/15/2018 11:59:05 AM ******/
CREATE NONCLUSTERED INDEX [Hint_SalesResultsDetails_OrderStatusId_OrderCompletionDate] ON [dbo].[SalesResultsDetails]
(
	[OrderStatusId] ASC,
	[OrderCompletionDate] ASC
)
INCLUDE ( 	[CompanyLocationId],
	[OrderId],
	[CompanyName],
	[NewSubtotal],
	[BillingAddress1],
	[BillingAddress2],
	[BillingCity],
	[BillingState],
	[BillingZip]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [SalesResultsDetails_CompanyLocationId]    Script Date: 5/15/2018 11:59:05 AM ******/
CREATE NONCLUSTERED INDEX [SalesResultsDetails_CompanyLocationId] ON [dbo].[SalesResultsDetails]
(
	[CompanyLocationId] ASC
)
INCLUDE ( 	[OrderId],
	[OrderCompletionDate],
	[CompanyName],
	[OrderContactName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[SalesResultsDetails] ADD  CONSTRAINT [DF_SalesResultsDetails_OLTP_InsertDate]  DEFAULT (getdate()) FOR [OLTP_InsertDate]
GO
