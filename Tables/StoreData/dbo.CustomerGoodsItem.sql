/****** Object:  Table [dbo].[CustomerGoodsItem]    Script Date: 5/15/2018 12:06:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CustomerGoodsItem](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[CategoryID] [int] NULL,
	[CategoryStoreID] [int] NULL,
	[CategoryClassTypeID] [int] NULL,
	[ItemName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HelpText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InternalNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BarCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsChildByDefault] [bit] NULL,
	[EquipmentCostFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LaborCostFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaterialCostFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductionTime] [int] NULL,
	[PrintAs] [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Question] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortOrder] [int] NULL,
	[ImageID] [int] NULL,
	[AccountCodeID] [int] NULL,
	[DefaultEntryOption] [int] NULL,
	[DefaultSelectionListID] [int] NULL,
	[IsTaxExempt] [bit] NULL,
	[PricingMethodID] [int] NULL,
	[DefaultLimitToList] [bit] NULL,
	[CustNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPartConsumptionFx] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPart2ConsumptionFx] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VarGridParam1ID] [int] NULL,
	[VarGridParam2ID] [int] NULL,
	[VarGridValues1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VarGridValues2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVarGridEnabled] [bit] NULL,
	[SaveTransRecord] [bit] NULL,
	[IsChildOnly] [bit] NULL,
	[ExcludePromotions] [bit] NULL,
	[Flags] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseCalendar] [bit] NULL,
	[UseCalendarForEstimates] [bit] NULL,
	[CalendarReqdForOrders] [bit] NULL,
	[CalendarReqdForServiceTickets] [bit] NULL,
	[CalendarReqdForEstimates] [bit] NULL,
	[CalendarRequireTime] [bit] NULL,
	[CalendarOffsetDays] [int] NULL,
	[UseCalendarTemplate] [bit] NULL,
	[CalendarTemplateID] [int] NULL,
	[CalendarTemplateStoreID] [int] NULL,
	[CalendarTemplateClassTypeID] [int] NULL,
	[DefaultStageID] [int] NULL,
	[ReCalcTransHeader] [bit] NULL,
	[PartConsumptionFormulas] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaximumSize] [int] NULL,
	[DefaultCalendarID] [int] NULL,
	[DefaultCalendarStoreID] [int] NULL,
	[DefaultCalendarClassTypeID] [int] NULL,
	[Color] [int] NULL,
	[MakeUpType] [int] NULL,
	[CanChangeMakeup] [bit] NULL,
	[NewEnrollmentOngoing] [bit] NULL,
	[ValidPeriodsString] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultStageClassTypeID] [int] NULL,
	[PartConsumptionUnitIDs] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FontColor] [int] NULL,
	[TaxCodeID] [int] NULL,
	[TaxCodeClassTypeID] [int] NULL,
	[IsScheduled] [bit] NULL,
	[DurationID] [int] NULL,
	[AlternatePercentCompletedFx] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsAssembly] [bit] NULL,
	[StationID] [int] NULL,
	[StationClassTypeID] [int] NULL,
	[UseParentStation] [bit] NULL,
	[IsLocked] [bit] NULL,
	[IsPricingLevelExempt] [bit] NULL,
	[ShowInWebView] [bit] NULL,
	[LocalTags] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HideOnSetupMenu] [bit] NULL,
	[UDFXML] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastModifiedDate] [datetime] NULL,
	[IsPriceLockExempt] [bit] NULL,
	[UseMultipleQuantityGrid] [bit] NULL,
	[MultipleQuantityGridXML] [xml] NULL,
 CONSTRAINT [CustomerGoodsItem_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_customergoodsItem_AccountCodeID]    Script Date: 5/15/2018 12:06:44 PM ******/
CREATE NONCLUSTERED INDEX [Index_customergoodsItem_AccountCodeID] ON [dbo].[CustomerGoodsItem]
(
	[AccountCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_customergoodsItem_categoryStoreID]    Script Date: 5/15/2018 12:06:44 PM ******/
CREATE NONCLUSTERED INDEX [Index_customergoodsItem_categoryStoreID] ON [dbo].[CustomerGoodsItem]
(
	[CategoryStoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Index_customergoodsItem_ItemName]    Script Date: 5/15/2018 12:06:44 PM ******/
CREATE NONCLUSTERED INDEX [Index_customergoodsItem_ItemName] ON [dbo].[CustomerGoodsItem]
(
	[ItemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_customergoodsItem]    Script Date: 5/15/2018 12:06:44 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_customergoodsItem] ON [dbo].[CustomerGoodsItem]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
