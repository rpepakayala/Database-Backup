/****** Object:  Table [dbo].[Order]    Script Date: 5/15/2018 12:04:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderGuid] [uniqueidentifier] NOT NULL,
	[StoreId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[BillingAddressId] [int] NOT NULL,
	[ShippingAddressId] [int] NULL,
	[PickUpInStore] [bit] NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[ShippingStatusId] [int] NOT NULL,
	[PaymentStatusId] [int] NOT NULL,
	[PaymentMethodSystemName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerCurrencyCode] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrencyRate] [decimal](18, 8) NOT NULL,
	[CustomerTaxDisplayTypeId] [int] NOT NULL,
	[VatNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderSubtotalInclTax] [decimal](18, 4) NOT NULL,
	[OrderSubtotalExclTax] [decimal](18, 4) NOT NULL,
	[OrderSubTotalDiscountInclTax] [decimal](18, 4) NOT NULL,
	[OrderSubTotalDiscountExclTax] [decimal](18, 4) NOT NULL,
	[OrderShippingInclTax] [decimal](18, 4) NOT NULL,
	[OrderShippingExclTax] [decimal](18, 4) NOT NULL,
	[PaymentMethodAdditionalFeeInclTax] [decimal](18, 4) NOT NULL,
	[PaymentMethodAdditionalFeeExclTax] [decimal](18, 4) NOT NULL,
	[TaxRates] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderTax] [decimal](18, 4) NOT NULL,
	[OrderDiscount] [decimal](18, 4) NOT NULL,
	[OrderTotal] [decimal](18, 4) NOT NULL,
	[RefundedAmount] [decimal](18, 4) NOT NULL,
	[RewardPointsWereAdded] [bit] NOT NULL,
	[CheckoutAttributeDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CheckoutAttributesXml] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerLanguageId] [int] NOT NULL,
	[AffiliateId] [int] NOT NULL,
	[CustomerIp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowStoringCreditCardNumber] [bit] NOT NULL,
	[CardType] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CardName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CardNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaskedCreditCardNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CardCvv2] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CardExpirationMonth] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CardExpirationYear] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AuthorizationTransactionId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AuthorizationTransactionCode] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AuthorizationTransactionResult] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CaptureTransactionId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CaptureTransactionResult] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SubscriptionTransactionId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaidDateUtc] [datetime] NULL,
	[ShippingMethod] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingRateComputationMethodSystemName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomValuesXml] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Order_CustomerId]    Script Date: 5/15/2018 12:04:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_CustomerId] ON [dbo].[Order]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [Order_BillingAddress] FOREIGN KEY([BillingAddressId])
REFERENCES [dbo].[Address] ([Id])
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [Order_BillingAddress]
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [Order_Customer]
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [Order_ShippingAddress] FOREIGN KEY([ShippingAddressId])
REFERENCES [dbo].[Address] ([Id])
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [Order_ShippingAddress]
GO
