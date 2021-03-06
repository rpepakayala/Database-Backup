/****** Object:  Table [dbo].[Ledger]    Script Date: 5/15/2018 12:06:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Ledger](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[EntryDateTime] [datetime] NULL,
	[Amount] [decimal](18, 4) NULL,
	[Classification] [int] NULL,
	[IsTaxable] [bit] NULL,
	[GroupID] [int] NULL,
	[GLAccountID] [int] NULL,
	[GLAccountClassTypeID] [int] NULL,
	[AccountID] [int] NULL,
	[AccountClassTypeID] [int] NULL,
	[TransactionID] [int] NULL,
	[TransactionClassTypeID] [int] NULL,
	[TransDetailID] [int] NULL,
	[TransDetailClassTypeID] [int] NULL,
	[GoodsItemID] [int] NULL,
	[GoodsItemClassTypeID] [int] NULL,
	[Description] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DivisionID] [int] NULL,
	[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsModified] [bit] NULL,
	[IsUser] [bit] NULL,
	[TaxClassID] [int] NULL,
	[Quantity] [float] NULL,
	[PartID] [int] NULL,
	[PartClassTypeID] [int] NULL,
	[JournalID] [int] NULL,
	[JournalClassTypeID] [int] NULL,
	[Reconciled] [bit] NULL,
	[ReconciliationDateTime] [datetime] NULL,
	[ReconciliationID] [int] NULL,
	[ReconciliationClassTypeID] [int] NULL,
	[ProcessedDivisionID] [int] NULL,
	[GLClassificationType] [int] NULL,
	[GLClassTypeName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TransPartID] [int] NULL,
	[TransPartClassTypeID] [int] NULL,
	[StationID] [int] NULL,
	[PayrollID] [int] NULL,
	[PayrollClassTypeID] [int] NULL,
	[DepositJournalID] [int] NULL,
	[EntryType] [int] NULL,
	[EmployeeID] [int] NULL,
	[OffBalanceSheet] [bit] NOT NULL,
	[WarehouseID] [int] NULL,
	[InventoryID] [int] NULL,
 CONSTRAINT [GL_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_GL_AccountID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_AccountID] ON [dbo].[Ledger]
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_GLAccountID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_GLAccountID] ON [dbo].[Ledger]
(
	[GLAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_GLGroupID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_GLGroupID] ON [dbo].[Ledger]
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_GoodsItemID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_GoodsItemID] ON [dbo].[Ledger]
(
	[GoodsItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_Index_DepositJournalID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_Index_DepositJournalID] ON [dbo].[Ledger]
(
	[DepositJournalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_Index_GLClassificationType]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_Index_GLClassificationType] ON [dbo].[Ledger]
(
	[GLClassificationType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_TransactionID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_TransactionID] ON [dbo].[Ledger]
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_GL_TransDetailID]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Index_GL_TransDetailID] ON [dbo].[Ledger]
(
	[TransDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_GL]    Script Date: 5/15/2018 12:06:48 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_GL] ON [dbo].[Ledger]
(
	[EntryDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Ledger] ADD  DEFAULT ((0)) FOR [OffBalanceSheet]
GO
