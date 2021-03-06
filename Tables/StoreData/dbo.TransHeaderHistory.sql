/****** Object:  Table [dbo].[TransHeaderHistory]    Script Date: 5/15/2018 12:07:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransHeaderHistory](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[TransactionType] [int] NULL,
	[EstimateNumber] [int] NULL,
	[OrderNumber] [int] NULL,
	[OrderTemplateNumber] [int] NULL,
	[Version] [int] NULL,
	[Description] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountID] [int] NULL,
	[AccountStoreID] [int] NULL,
	[ContactID] [int] NULL,
	[SalesPerson1ID] [int] NULL,
	[SalesPerson2ID] [int] NULL,
	[SalesPerson3ID] [int] NULL,
	[OrderNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PONumber] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductionNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PricingLevel] [float] NULL,
	[PricingLevelOverridden] [bit] NULL,
	[DiscountLevel] [float] NULL,
	[DiscountLevelOverridden] [bit] NULL,
	[EstimateCreatedDate] [datetime] NULL,
	[OrderCreatedDate] [datetime] NULL,
	[BuiltDate] [datetime] NULL,
	[SaleDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL,
	[VoidedDate] [datetime] NULL,
	[ConvertedDate] [datetime] NULL,
	[RejectedDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ProofDate] [datetime] NULL,
	[LastFinanceChargeDate] [datetime] NULL,
	[DispositionID] [int] NULL,
	[SalesDispositionID] [int] NULL,
	[EnteredByID] [int] NULL,
	[HTMLShortFormat] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HTMLLongFormat] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BasePrice] [float] NULL,
	[DiscountPrice] [float] NULL,
	[ModifierPrice] [float] NULL,
	[RawSubTotalPrice] [float] NULL,
	[RoundingPrice] [float] NULL,
	[SubTotalPrice] [float] NULL,
	[TaxesPrice] [float] NULL,
	[TotalPrice] [float] NULL,
	[SonsBasePrice] [float] NULL,
	[SonsDiscountPrice] [float] NULL,
	[SonsModifierPrice] [float] NULL,
	[SonsRawSubTotalPrice] [float] NULL,
	[SonsRoundingPrice] [float] NULL,
	[SonsSubTotalPrice] [float] NULL,
	[SonsTaxesPrice] [float] NULL,
	[SonsTotalPrice] [float] NULL,
	[FinanceChargeAmount] [float] NULL,
	[BalanceDue] [float] NULL,
	[PaymentTotal] [float] NULL,
	[WriteOffAmount] [float] NULL,
	[StatusID] [int] NULL,
	[StatusText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxClassID] [int] NULL,
	[TaxClassOverridden] [bit] NULL,
	[InvoiceAddressID] [int] NULL,
	[InvoiceAddressOverridden] [bit] NULL,
	[InvoiceContactID] [int] NULL,
	[ShippingAddressID] [int] NULL,
	[ShippingAddressOverridden] [bit] NULL,
	[ShippingContactID] [int] NULL,
	[InvoiceAddressLinkID] [int] NULL,
	[ShippingAddressLinkID] [int] NULL,
	[EstimateGreeting] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EstimateGreetingTemplate] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsTaxExempt] [bit] NULL,
	[TaxNumber] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderOriginID] [int] NULL,
	[OrderOriginName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManuallyReOpened] [bit] NULL,
	[CreditMemoAmount] [float] NULL,
	[CreditMemoOrderID] [int] NULL,
	[NextRefNumber] [int] NULL,
	[PricingLevelID] [int] NULL,
	[PromotionID] [int] NULL,
	[UseTaxLookup] [bit] NULL,
	[TaxItems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InvoiceNumber] [int] NULL,
	[ServiceTicketNumber] [int] NULL,
	[DivisionID] [int] NULL,
	[DivisionIDOverridden] [bit] NULL,
	[OrderNotesTemplate] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductionNotesTemplate] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsFirmDueDate] [bit] NULL,
	[ShippingCompanyID] [int] NULL,
	[ShippingCompanyOV] [bit] NULL,
	[ShippingContactOV] [bit] NULL,
	[InvoiceCompanyID] [int] NULL,
	[InvoiceCompanyOV] [bit] NULL,
	[InvoiceContactOV] [bit] NULL,
	[UseProgressBilling] [bit] NULL,
	[PercentComplete] [float] NULL,
	[RecurrenceType] [int] NULL,
	[RecurrenceEndDate] [datetime] NULL,
	[LastRecurrence] [datetime] NULL,
	[ScheduledPaymentPlanID] [int] NULL,
	[ScheduledPaymentDate] [datetime] NULL,
	[ScheduledPayments] [int] NULL,
	[ScheduledPaymentIntervals] [int] NULL,
	[UsePaymentPlan] [bit] NULL,
	[DroppedDate] [datetime] NULL,
	[PurchaseOrderNumber] [int] NULL,
	[POPaymentTermsID] [int] NULL,
	[POShippingMethodID] [int] NULL,
	[RequestedDate] [datetime] NULL,
	[ApprovedDate] [datetime] NULL,
	[OrderedDate] [datetime] NULL,
	[ReceivedDate] [datetime] NULL,
	[RequestedByID] [int] NULL,
	[ApprovedByID] [int] NULL,
	[OrderedByID] [int] NULL,
	[ReceivedByID] [int] NULL,
	[ShipFromAddressLinkID] [int] NULL,
	[ShipFromAddressID] [int] NULL,
	[ShipFromID] [int] NULL,
	[IsValidTax] [bit] NULL,
	[TipsAmount] [float] NULL,
	[TipsPaidOut] [float] NULL,
	[BillNumber] [int] NULL,
	[ReceivingDocNumber] [int] NULL,
	[BillDate] [datetime] NULL,
	[ShipFromClassTypeID] [int] NULL,
	[ShipFromAddressOverridden] [bit] NULL,
	[ExpectedPayID] [int] NULL,
	[ExpectedPayClassTypeID] [int] NULL,
	[StationID] [int] NULL,
	[StationClassTypeID] [int] NULL,
	[SalesStationID] [int] NULL,
	[SalesStationClassTypeID] [int] NULL,
	[DefaultOrderID] [int] NULL,
	[DefaultOrderClassTypeID] [int] NULL,
	[DefaultOrderItemID] [int] NULL,
	[DefaultOrderItemClassTypeID] [int] NULL,
	[TaxablePrice] [float] NULL,
	[SonsTaxablePrice] [float] NULL,
	[StationActivityID] [int] NULL,
	[StationActivityClassTypeID] [int] NULL,
	[PayrollID] [int] NULL,
	[PayrollClassTypeID] [int] NULL,
	[EarlyPaymentDiscountOVAmount] [float] NULL,
	[IsEarlyPaymentDiscountOV] [bit] NULL,
	[RecurrenceStartDate] [datetime] NULL,
	[IsReturnDocument] [bit] NULL,
	[WarehouseID] [int] NULL,
	[WarehouseIDOV] [bit] NULL,
	[FinanceChargeTaxXML] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsPricingLocked] [bit] NULL,
	[ShipFromPhoneNumberID] [int] NULL,
	[ShipFromEmailAddress] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseShippingAccountInfo] [bit] NULL,
	[ShippingAccountNumber] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingCarrierID] [int] NULL,
	[ShippingCarrierClassTypeID] [int] NULL,
	[ShippingAccountPostalCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipmentType] [int] NULL,
	[ShipmentTypeText] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsShippingLocked] [bit] NULL,
	[ShipFromCustomerID] [int] NULL,
	[ShipFromCustomerClassTypeID] [int] NULL,
	[ShipFromDivisionID] [int] NULL,
	[ShipFromDivisionClassTypeID] [int] NULL,
	[OverriddenUserFields] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [TransHeaderHistory_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_TransHeaderHistory_InvoiceCompanyIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_InvoiceCompanyIndex] ON [dbo].[TransHeaderHistory]
(
	[InvoiceCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Index_TransHeaderHistory_PONumber]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_PONumber] ON [dbo].[TransHeaderHistory]
(
	[PONumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_SalesStationClassTypeID]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_SalesStationClassTypeID] ON [dbo].[TransHeaderHistory]
(
	[SalesStationClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_SalesStationID]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_SalesStationID] ON [dbo].[TransHeaderHistory]
(
	[SalesStationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_ShipFromAddressIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_ShipFromAddressIndex] ON [dbo].[TransHeaderHistory]
(
	[ShipFromAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_ShipFromAddressLinkIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_ShipFromAddressLinkIndex] ON [dbo].[TransHeaderHistory]
(
	[ShipFromAddressLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_ShipFromIDIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_ShipFromIDIndex] ON [dbo].[TransHeaderHistory]
(
	[ShipFromID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_ShippingCompanyIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_ShippingCompanyIndex] ON [dbo].[TransHeaderHistory]
(
	[ShippingCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeader_ServiceTicketNum]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeader_ServiceTicketNum] ON [dbo].[TransHeaderHistory]
(
	[ServiceTicketNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_Account]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_Account] ON [dbo].[TransHeaderHistory]
(
	[AccountID] ASC,
	[AccountStoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_Contact]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_Contact] ON [dbo].[TransHeaderHistory]
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_Disposition]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_Disposition] ON [dbo].[TransHeaderHistory]
(
	[DispositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_EnteredBy]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_EnteredBy] ON [dbo].[TransHeaderHistory]
(
	[EnteredByID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_SalesDisposition]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_SalesDisposition] ON [dbo].[TransHeaderHistory]
(
	[SalesDispositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_SalesPerson1]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_SalesPerson1] ON [dbo].[TransHeaderHistory]
(
	[SalesPerson1ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_SalesPerson2]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_SalesPerson2] ON [dbo].[TransHeaderHistory]
(
	[SalesPerson2ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_siTransHeaderHistory_SalesPerson3]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_siTransHeaderHistory_SalesPerson3] ON [dbo].[TransHeaderHistory]
(
	[SalesPerson3ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_StationClassTypeID]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_StationClassTypeID] ON [dbo].[TransHeaderHistory]
(
	[StationClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransHeaderHistory_StationID]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransHeaderHistory_StationID] ON [dbo].[TransHeaderHistory]
(
	[StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
