/****** Object:  Table [Product].[ProductFact]    Script Date: 5/15/2018 11:59:42 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Product].[ProductFact](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductCodeKey] [int] NULL,
	[ProductCategoryID] [int] NULL,
	[VolumeCategoryID] [int] NULL,
	[AVICategoryID] [int] NULL,
	[DescriptionKey] [int] NULL,
	[PricingStructure] [smallint] NULL,
	[DefaultProductionLocation] [smallint] NULL,
	[ForegroundColorsKey] [int] NULL,
	[BackgroundColorKey] [int] NULL,
	[Font] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriceBasedOnKey] [int] NULL,
	[DefaultHeight] [float] NULL,
	[DefaultWidth] [float] NULL,
	[InputUnits] [smallint] NULL,
	[PricingUnits] [smallint] NULL,
	[ThicknessKey] [int] NULL,
	[MinNumberSides] [smallint] NULL,
	[MaxNumberSides] [smallint] NULL,
	[DefaultSides] [smallint] NULL,
	[SecondSidePremium] [float] NULL,
	[SetupCharge] [money] NULL,
	[MinUnitPrice] [money] NULL,
	[MinLineItemPrice] [money] NULL,
	[BaseUnitCharge] [money] NULL,
	[Taxable] [bit] NULL,
	[AllInstallation] [bit] NULL,
	[StandardDeliveryTime] [float] NULL,
	[ProductionRate] [float] NULL,
	[RoundingType] [int] NULL,
	[FGColorListID] [int] NULL,
	[RestrictFGColorToList] [bit] NULL,
	[BGColorListID] [int] NULL,
	[RestrictBGColorToList] [bit] NULL,
	[FontListID] [bit] NULL,
	[RestrictFontToList] [bit] NULL,
	[RoundSizeToTable] [bit] NULL,
	[ExtrapolateTable] [bit] NULL,
	[FixedPerPieceCharge] [money] NULL,
	[SecondSideSetup] [bit] NULL,
	[SecondSidePerPieceCharge] [money] NULL,
	[ProductImageID] [int] NULL,
	[PriceSheetID] [int] NULL,
	[BaseUnitCost] [float] NULL,
	[DetailDescriptionKey] [int] NULL,
	[SymmetricTable] [bit] NULL,
	[TotalSizeDiscounts] [bit] NULL,
	[InterpolateTable] [bit] NULL,
	[MaterialTypeNameKey] [int] NULL,
	[ChargeForScrap] [bit] NULL,
	[ScrapChargeRate] [float] NULL,
	[MaterialHeight] [float] NULL,
	[MaterialWidth] [float] NULL,
	[MaterialDepth] [float] NULL,
	[PanelMaterial] [bit] NULL,
	[PanelGap] [float] NULL,
	[Material2Sided] [bit] NULL,
	[HiddenByDefault] [bit] NULL,
	[ProductActive] [bit] NULL,
	[CostToPriceMargin] [float] NULL,
	[PriceFormulaKey] [int] NULL,
	[CostFormulaKey] [int] NULL,
	[OEEntryFormatID] [int] NULL,
	[SetupFormulaKey] [int] NULL,
	[TilePieces] [bit] NULL,
	[RotatePieces] [bit] NULL,
	[AvoidPaneling] [bit] NULL,
	[ChargeForExtraPanels] [bit] NULL,
	[PanelChargeRate] [float] NULL,
	[PanelChargeAmount] [money] NULL,
	[DefaultProdNotesKey] [int] NULL,
	[xSortMarker] [bit] NULL,
	[LimitToTable] [bit] NULL,
	[FlagsKey] [int] NULL,
	[RoyaltyGroupID] [int] NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
	[CenterKey] [int] NULL,
	[KeystoneProductKey] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ProductFact] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Hint_ProductCodeKey_inc_ProductKey]    Script Date: 5/15/2018 11:59:42 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ProductCodeKey_inc_ProductKey] ON [Product].[ProductFact]
(
	[ProductCodeKey] ASC
)
INCLUDE ( 	[ProductKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_ProductFact_ZW_Franchise_ID_inc_ProductID_ProductCategoryID]    Script Date: 5/15/2018 11:59:42 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ProductFact_ZW_Franchise_ID_inc_ProductID_ProductCategoryID] ON [Product].[ProductFact]
(
	[ZW_Franchise_ID] ASC
)
INCLUDE ( 	[ProductID],
	[ProductCategoryID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Product].[ProductFact] ADD  CONSTRAINT [DF_ProductFact_CenterKey]  DEFAULT ((-255)) FOR [CenterKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_BackgroundColorKey] FOREIGN KEY([BackgroundColorKey])
REFERENCES [Product].[BackgroundColorDim] ([BackgroundColorKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_BackgroundColorKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_CostFormulaKey] FOREIGN KEY([CostFormulaKey])
REFERENCES [Product].[CostFormulaDim] ([CostFormulaKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_CostFormulaKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_DefaultProdNotesKey] FOREIGN KEY([DefaultProdNotesKey])
REFERENCES [Product].[DefaultProdNotesDim] ([DefaultProdNotesKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_DefaultProdNotesKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_DescriptionKey] FOREIGN KEY([DescriptionKey])
REFERENCES [Product].[DescriptionDim] ([DescriptionKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_DescriptionKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_DetailDescriptionKey] FOREIGN KEY([DetailDescriptionKey])
REFERENCES [Product].[DetailDescriptionDim] ([DetailDescriptionKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_DetailDescriptionKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_FlagsKey] FOREIGN KEY([FlagsKey])
REFERENCES [Product].[FlagsDim] ([FlagsKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_FlagsKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_ForegroundColorsKey] FOREIGN KEY([ForegroundColorsKey])
REFERENCES [Product].[ForegroundColorsDim] ([ForegroundColorsKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_ForegroundColorsKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_MaterialTypeNameKey] FOREIGN KEY([MaterialTypeNameKey])
REFERENCES [Product].[MaterialTypeNameDim] ([MaterialTypeNameKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_MaterialTypeNameKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_PriceBasedOnKey] FOREIGN KEY([PriceBasedOnKey])
REFERENCES [Product].[PriceBasedOnDim] ([PriceBasedOnKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_PriceBasedOnKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_PriceFormulaKey] FOREIGN KEY([PriceFormulaKey])
REFERENCES [Product].[PriceFormulaDim] ([PriceFormulaKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_PriceFormulaKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_ProductCodeKey] FOREIGN KEY([ProductCodeKey])
REFERENCES [Product].[ProductCodeDim] ([ProductCodeKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_ProductCodeKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_SetupFormulaKey] FOREIGN KEY([SetupFormulaKey])
REFERENCES [Product].[SetupFormulaDim] ([SetupFormulaKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_SetupFormulaKey]
ALTER TABLE [Product].[ProductFact]  WITH CHECK ADD  CONSTRAINT [FK_ProductFact_ThicknessKey] FOREIGN KEY([ThicknessKey])
REFERENCES [Product].[ThicknessDim] ([ThicknessKey])
ALTER TABLE [Product].[ProductFact] CHECK CONSTRAINT [FK_ProductFact_ThicknessKey]
GO
