/****** Object:  Table [dbo].[ProductVariant]    Script Date: 5/15/2018 12:03:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductVariant](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sku] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AdminComment] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManufacturerPartNumber] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsGiftCard] [bit] NOT NULL,
	[GiftCardTypeId] [int] NOT NULL,
	[IsDownload] [bit] NOT NULL,
	[DownloadId] [int] NOT NULL,
	[UnlimitedDownloads] [bit] NOT NULL,
	[MaxNumberOfDownloads] [int] NOT NULL,
	[DownloadExpirationDays] [int] NULL,
	[DownloadActivationTypeId] [int] NOT NULL,
	[HasSampleDownload] [bit] NOT NULL,
	[SampleDownloadId] [int] NOT NULL,
	[HasUserAgreement] [bit] NOT NULL,
	[UserAgreementText] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsRecurring] [bit] NOT NULL,
	[RecurringCycleLength] [int] NOT NULL,
	[RecurringCyclePeriodId] [int] NOT NULL,
	[RecurringTotalCycles] [int] NOT NULL,
	[IsShipEnabled] [bit] NOT NULL,
	[IsFreeShipping] [bit] NOT NULL,
	[AdditionalShippingCharge] [decimal](18, 4) NOT NULL,
	[IsTaxExempt] [bit] NOT NULL,
	[TaxCategoryId] [int] NOT NULL,
	[ManageInventoryMethodId] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[DisplayStockAvailability] [bit] NOT NULL,
	[DisplayStockQuantity] [bit] NOT NULL,
	[MinStockQuantity] [int] NOT NULL,
	[LowStockActivityId] [int] NOT NULL,
	[NotifyAdminForQuantityBelow] [int] NOT NULL,
	[BackorderModeId] [int] NOT NULL,
	[OrderMinimumQuantity] [int] NOT NULL,
	[OrderMaximumQuantity] [int] NOT NULL,
	[DisableBuyButton] [bit] NOT NULL,
	[DisableWishlistButton] [bit] NOT NULL,
	[CallForPrice] [bit] NOT NULL,
	[Price] [decimal](18, 4) NOT NULL,
	[OldPrice] [decimal](18, 4) NOT NULL,
	[ProductCost] [decimal](18, 4) NOT NULL,
	[CustomerEntersPrice] [bit] NOT NULL,
	[MinimumCustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[MaximumCustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[Weight] [decimal](18, 4) NOT NULL,
	[Length] [decimal](18, 4) NOT NULL,
	[Width] [decimal](18, 4) NOT NULL,
	[Height] [decimal](18, 4) NOT NULL,
	[PictureId] [int] NOT NULL,
	[AvailableStartDateTimeUtc] [datetime] NULL,
	[AvailableEndDateTimeUtc] [datetime] NULL,
	[Published] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_StoreId_inc_ProductId_Sku]    Script Date: 5/15/2018 12:03:31 PM ******/
CREATE NONCLUSTERED INDEX [Hint_StoreId_inc_ProductId_Sku] ON [dbo].[ProductVariant]
(
	[StoreId] ASC
)
INCLUDE ( 	[ProductId],
	[Sku]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_ProductVariant_DisplayOrder]    Script Date: 5/15/2018 12:03:31 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductVariant_DisplayOrder] ON [dbo].[ProductVariant]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_ProductVariant_ProductId]    Script Date: 5/15/2018 12:03:31 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductVariant_ProductId] ON [dbo].[ProductVariant]
(
	[ProductId] ASC
)
INCLUDE ( 	[Price],
	[AvailableStartDateTimeUtc],
	[AvailableEndDateTimeUtc],
	[Published],
	[Deleted],
	[StoreId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[ProductVariant]  WITH CHECK ADD  CONSTRAINT [ProductVariant_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductVariant] CHECK CONSTRAINT [ProductVariant_Product]
ALTER TABLE [dbo].[ProductVariant]  WITH CHECK ADD  CONSTRAINT [ProductVariant_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ALTER TABLE [dbo].[ProductVariant] CHECK CONSTRAINT [ProductVariant_Store]
GO
