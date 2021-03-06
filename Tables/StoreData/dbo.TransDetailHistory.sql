/****** Object:  Table [dbo].[TransDetailHistory]    Script Date: 5/15/2018 12:07:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransDetailHistory](
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
	[ParentID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[TransHeaderID] [int] NULL,
	[TransHeaderClassTypeID] [int] NULL,
	[TransHeaderTransNumber] [int] NULL,
	[GoodsItemID] [int] NULL,
	[GoodsItemClassTypeID] [int] NULL,
	[GoodsItemCode] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PricingLevel] [float] NULL,
	[PricingLevelOverridden] [bit] NULL,
	[DiscountLevel] [float] NULL,
	[DiscountLevelOverridden] [bit] NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [float] NULL,
	[LineItemIndex] [int] NULL,
	[LineItemNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HTMLShortFormat] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HTMLLongFormat] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BasePrice] [float] NULL,
	[BaseCalcPrice] [float] NULL,
	[BaseOverriddenPrice] [float] NULL,
	[BaseIsOverridden] [bit] NULL,
	[DiscountPrice] [float] NULL,
	[DiscountCalcPrice] [float] NULL,
	[DiscountOverriddenPrice] [float] NULL,
	[DiscountIsOverridden] [bit] NULL,
	[ModifierPrice] [float] NULL,
	[ModifierCalcPrice] [float] NULL,
	[ModifierOverriddenPrice] [float] NULL,
	[ModifierIsOverridden] [bit] NULL,
	[RawSubTotalPrice] [float] NULL,
	[RawSubTotalCalcPrice] [float] NULL,
	[RawSubTotalOverriddenPrice] [float] NULL,
	[RawSubTotalIsOverridden] [bit] NULL,
	[RoundingPrice] [float] NULL,
	[RoundingCalcPrice] [float] NULL,
	[RoundingOverriddenPrice] [float] NULL,
	[RoundingIsOverridden] [bit] NULL,
	[SubTotalPrice] [float] NULL,
	[SubTotalCalcPrice] [float] NULL,
	[SubTotalOverriddenPrice] [float] NULL,
	[SubTotalIsOverridden] [bit] NULL,
	[TaxesPrice] [float] NULL,
	[TaxesCalcPrice] [float] NULL,
	[TaxesOverriddenPrice] [float] NULL,
	[TaxesIsOverridden] [bit] NULL,
	[TotalPrice] [float] NULL,
	[TotalCalcPrice] [float] NULL,
	[TotalOverriddenPrice] [float] NULL,
	[TotalIsOverridden] [bit] NULL,
	[MeAndSonsBasePrice] [float] NULL,
	[MeAndSonsDiscountPrice] [float] NULL,
	[MeAndSonsModifierPrice] [float] NULL,
	[MeAndSonsRawSubTotalPrice] [float] NULL,
	[MeAndSonsRoundingPrice] [float] NULL,
	[MeAndSonsSubTotalPrice] [float] NULL,
	[MeAndSonsTaxesPrice] [float] NULL,
	[MeAndSonsTotalPrice] [float] NULL,
	[InternalNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitParamName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitParamValue] [float] NULL,
	[VariationID] [int] NULL,
	[ImageParamID] [int] NULL,
	[ImageParamStoreID] [int] NULL,
	[ImageParamClassTypeID] [int] NULL,
	[StageID] [int] NULL,
	[StageStoreID] [int] NULL,
	[StageClassTypeID] [int] NULL,
	[SaleAccountID] [int] NULL,
	[SaleAccountStoreID] [int] NULL,
	[SaleAccountClassTypeID] [int] NULL,
	[SaleAccountOverridden] [bit] NULL,
	[ChildItemCount] [int] NULL,
	[ParameterStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifierStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VarGridParam1ID] [int] NULL,
	[VarGridParam2ID] [int] NULL,
	[VarGridValues1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VarGridValues2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VarGridParam1OV] [bit] NULL,
	[VarGridParam2OV] [bit] NULL,
	[TaxItems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsComplete] [bit] NULL,
	[AssignedToID] [int] NULL,
	[TicketItemNumber] [int] NULL,
	[ShippingCompanyID] [int] NULL,
	[ShippingCompanyOV] [bit] NULL,
	[ShippingContactID] [int] NULL,
	[ShippingContactOV] [bit] NULL,
	[ShippingAddressID] [int] NULL,
	[ShippingAddressLinkID] [int] NULL,
	[ShippingAddressOV] [bit] NULL,
	[ShippingTaxClassID] [int] NULL,
	[ShippingTaxClassOV] [bit] NULL,
	[TotMaterialCost] [float] NULL,
	[TotLaborCost] [float] NULL,
	[TotEquipmentCost] [float] NULL,
	[TotOutSourceCost] [float] NULL,
	[TotOtherCost] [float] NULL,
	[TotPartCost] [float] NULL,
	[HasWorkAssignment] [bit] NULL,
	[WorkAssignmentID] [int] NULL,
	[WorkAssignmentStoreID] [int] NULL,
	[WorkAssignmentClassTypeID] [int] NULL,
	[TotFreightCost] [float] NULL,
	[PriorityID] [int] NULL,
	[PriorityStoreID] [int] NULL,
	[PriorityClassTypeID] [int] NULL,
	[AssignedToClassTypeID] [int] NULL,
	[ProofApproved] [bit] NULL,
	[ProofApprovedDate] [datetime] NULL,
	[ProofApprovedByID] [int] NULL,
	[PercentComplete] [float] NULL,
	[PercentCompleteOV] [bit] NULL,
	[TermID] [int] NULL,
	[ContractPeriodID] [int] NULL,
	[ContractStartDate] [datetime] NULL,
	[ContractEndDate] [datetime] NULL,
	[ShipFromAddressID] [int] NULL,
	[ShipFromAddressLinkID] [int] NULL,
	[ShipFromAddressOV] [bit] NULL,
	[IsValidTax] [bit] NULL,
	[TaxNumber] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipFromID] [int] NULL,
	[ShipFromClassTypeID] [int] NULL,
	[AssemblyIncluded] [bit] NULL,
	[AssemblyIncludedOV] [bit] NULL,
	[AssemblyLocked] [bit] NULL,
	[AssemblyLinkID] [int] NULL,
	[AssemblyLinkClassTypeID] [int] NULL,
	[OverriddenAssemblies] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StationID] [int] NULL,
	[StationClassTypeID] [int] NULL,
	[GLDepartmentID] [int] NULL,
	[GLDepartmentIDOV] [bit] NULL,
	[TaxablePrice] [float] NULL,
	[MeAndSonsTaxablePrice] [float] NULL,
	[StationActivityID] [int] NULL,
	[StationActivityClassTypeID] [int] NULL,
	[MaterialExpenseID] [int] NULL,
	[LaborExpenseID] [int] NULL,
	[EquipmentExpenseID] [int] NULL,
	[OutsourceExpenseID] [int] NULL,
	[OtherExpenseID] [int] NULL,
	[FreightExpenseID] [int] NULL,
	[LocationExpenseID] [int] NULL,
	[UseParentExpenseAccounts] [bit] NULL,
	[WarehouseID] [int] NULL,
	[WarehouseIDOV] [bit] NULL,
	[RanReturnSQLFuncStatements] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QuantityShipped] [float] NULL,
 CONSTRAINT [TransDetailHistory_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_TransDetailHistory_AssignedToID]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_AssignedToID] ON [dbo].[TransDetailHistory]
(
	[AssignedToID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShipFromAddressIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShipFromAddressIndex] ON [dbo].[TransDetailHistory]
(
	[ShipFromAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShipFromAddressLinkIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShipFromAddressLinkIndex] ON [dbo].[TransDetailHistory]
(
	[ShipFromAddressLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShipFromIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShipFromIndex] ON [dbo].[TransDetailHistory]
(
	[ShipFromID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShippingAddressIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShippingAddressIndex] ON [dbo].[TransDetailHistory]
(
	[ShippingAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShippingAddressLinkIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShippingAddressLinkIndex] ON [dbo].[TransDetailHistory]
(
	[ShippingAddressLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShippingCompanyIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShippingCompanyIndex] ON [dbo].[TransDetailHistory]
(
	[ShippingCompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShippingContactIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShippingContactIndex] ON [dbo].[TransDetailHistory]
(
	[ShippingContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_ShippingTaxClassIndex]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_ShippingTaxClassIndex] ON [dbo].[TransDetailHistory]
(
	[ShippingTaxClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_Station]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_Station] ON [dbo].[TransDetailHistory]
(
	[StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_TermID]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_TermID] ON [dbo].[TransDetailHistory]
(
	[TermID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_TransDetailHistory_TicketItemNumber]    Script Date: 5/15/2018 12:07:00 PM ******/
CREATE NONCLUSTERED INDEX [Index_TransDetailHistory_TicketItemNumber] ON [dbo].[TransDetailHistory]
(
	[TicketItemNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
