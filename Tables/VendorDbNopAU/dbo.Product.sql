/****** Object:  Table [dbo].[Product]    Script Date: 5/15/2018 12:07:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeId] [int] NOT NULL,
	[ParentGroupedProductId] [int] NOT NULL,
	[VisibleIndividually] [bit] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ShortDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FullDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AdminComment] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductTemplateId] [int] NOT NULL,
	[VendorId] [int] NOT NULL,
	[ShowOnHomePage] [bit] NOT NULL,
	[MetaKeywords] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaTitle] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowCustomerReviews] [bit] NOT NULL,
	[ApprovedRatingSum] [int] NOT NULL,
	[NotApprovedRatingSum] [int] NOT NULL,
	[ApprovedTotalReviews] [int] NOT NULL,
	[NotApprovedTotalReviews] [int] NOT NULL,
	[SubjectToAcl] [bit] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[Sku] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManufacturerPartNumber] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Gtin] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsGiftCard] [bit] NOT NULL,
	[GiftCardTypeId] [int] NOT NULL,
	[RequireOtherProducts] [bit] NOT NULL,
	[RequiredProductIds] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AutomaticallyAddRequiredProducts] [bit] NOT NULL,
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
	[DeliveryDateId] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
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
	[AllowBackInStockSubscriptions] [bit] NOT NULL,
	[OrderMinimumQuantity] [int] NOT NULL,
	[OrderMaximumQuantity] [int] NOT NULL,
	[AllowedQuantities] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowAddingOnlyExistingAttributeCombinations] [bit] NOT NULL,
	[DisableBuyButton] [bit] NOT NULL,
	[DisableWishlistButton] [bit] NOT NULL,
	[AvailableForPreOrder] [bit] NOT NULL,
	[PreOrderAvailabilityStartDateTimeUtc] [datetime] NULL,
	[CallForPrice] [bit] NOT NULL,
	[Price] [decimal](18, 4) NOT NULL,
	[OldPrice] [decimal](18, 4) NOT NULL,
	[ProductCost] [decimal](18, 4) NOT NULL,
	[SpecialPrice] [decimal](18, 4) NULL,
	[SpecialPriceStartDateTimeUtc] [datetime] NULL,
	[SpecialPriceEndDateTimeUtc] [datetime] NULL,
	[CustomerEntersPrice] [bit] NOT NULL,
	[MinimumCustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[MaximumCustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[HasTierPrices] [bit] NOT NULL,
	[HasDiscountsApplied] [bit] NOT NULL,
	[Weight] [decimal](18, 4) NOT NULL,
	[Length] [decimal](18, 4) NOT NULL,
	[Width] [decimal](18, 4) NOT NULL,
	[Height] [decimal](18, 4) NOT NULL,
	[AvailableStartDateTimeUtc] [datetime] NULL,
	[AvailableEndDateTimeUtc] [datetime] NULL,
	[DisplayOrder] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL,
	[ShipSeparately] [bit] NOT NULL,
	[UseMultipleWarehouses] [bit] NOT NULL,
	[IsRental] [bit] NOT NULL,
	[RentalPriceLength] [int] NOT NULL,
	[RentalPricePeriodId] [int] NOT NULL,
	[IsTelecommunicationsOrBroadcastingOrElectronicServices] [bit] NOT NULL,
	[BasepriceEnabled] [bit] NOT NULL,
	[BasepriceAmount] [decimal](18, 4) NOT NULL,
	[BasepriceUnitId] [int] NOT NULL,
	[BasepriceBaseAmount] [decimal](18, 4) NOT NULL,
	[BasepriceBaseUnitId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Product_Deleted_and_Published]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Deleted_and_Published] ON [dbo].[Product]
(
	[Published] ASC,
	[Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_LimitedToStores]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_LimitedToStores] ON [dbo].[Product]
(
	[LimitedToStores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_ParentGroupedProductId]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ParentGroupedProductId] ON [dbo].[Product]
(
	[ParentGroupedProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_PriceDatesEtc]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_PriceDatesEtc] ON [dbo].[Product]
(
	[Price] ASC,
	[AvailableStartDateTimeUtc] ASC,
	[AvailableEndDateTimeUtc] ASC,
	[Published] ASC,
	[Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_Published]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Published] ON [dbo].[Product]
(
	[Published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_ShowOnHomepage]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ShowOnHomepage] ON [dbo].[Product]
(
	[ShowOnHomePage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_SubjectToAcl]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_SubjectToAcl] ON [dbo].[Product]
(
	[SubjectToAcl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_VisibleIndividually]    Script Date: 5/15/2018 12:07:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_VisibleIndividually] ON [dbo].[Product]
(
	[VisibleIndividually] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
