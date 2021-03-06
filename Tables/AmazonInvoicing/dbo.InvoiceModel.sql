/****** Object:  Table [dbo].[InvoiceModel]    Script Date: 5/15/2018 11:58:41 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InvoiceModel](
	[OrderId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[WebNumber] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[RequesterName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RequesterEmail] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrencyCode] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BuyerTaxId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SellerTaxId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReceiveByDate] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxRate] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RegionId] [int] NOT NULL,
	[ShippingTotal] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxTotal] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderSubtotal] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderTotal] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryAddress_OrderId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryAddress_Id] [int] NULL,
	[PurchaserAddress_OrderId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PurchaserAddress_Id] [int] NULL,
	[SupplierAddress_OrderId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SupplierAddress_Id] [int] NULL,
 CONSTRAINT [PK_dbo.InvoiceModel] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[InvoiceModel]  WITH CHECK ADD  CONSTRAINT [FK_dbo.InvoiceModel_dbo.InvoiceAddress_DeliveryAddress_OrderId_DeliveryAddress_Id] FOREIGN KEY([DeliveryAddress_OrderId], [DeliveryAddress_Id])
REFERENCES [dbo].[InvoiceAddress] ([OrderId], [Id])
ALTER TABLE [dbo].[InvoiceModel] CHECK CONSTRAINT [FK_dbo.InvoiceModel_dbo.InvoiceAddress_DeliveryAddress_OrderId_DeliveryAddress_Id]
ALTER TABLE [dbo].[InvoiceModel]  WITH CHECK ADD  CONSTRAINT [FK_dbo.InvoiceModel_dbo.InvoiceAddress_PurchaserAddress_OrderId_PurchaserAddress_Id] FOREIGN KEY([PurchaserAddress_OrderId], [PurchaserAddress_Id])
REFERENCES [dbo].[InvoiceAddress] ([OrderId], [Id])
ALTER TABLE [dbo].[InvoiceModel] CHECK CONSTRAINT [FK_dbo.InvoiceModel_dbo.InvoiceAddress_PurchaserAddress_OrderId_PurchaserAddress_Id]
ALTER TABLE [dbo].[InvoiceModel]  WITH CHECK ADD  CONSTRAINT [FK_dbo.InvoiceModel_dbo.InvoiceAddress_SupplierAddress_OrderId_SupplierAddress_Id] FOREIGN KEY([SupplierAddress_OrderId], [SupplierAddress_Id])
REFERENCES [dbo].[InvoiceAddress] ([OrderId], [Id])
ALTER TABLE [dbo].[InvoiceModel] CHECK CONSTRAINT [FK_dbo.InvoiceModel_dbo.InvoiceAddress_SupplierAddress_OrderId_SupplierAddress_Id]
GO
