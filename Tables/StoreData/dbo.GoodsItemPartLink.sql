/****** Object:  Table [dbo].[GoodsItemPartLink]    Script Date: 5/15/2018 12:06:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GoodsItemPartLink](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[PartID] [int] NULL,
	[GoodsItemID] [int] NULL,
	[GoodsItemClassTypeID] [int] NULL,
	[ConsumptionFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InclusionFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IncludeAlways] [bit] NULL,
	[ConsumptionUnitID] [int] NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StationID] [int] NULL,
	[StationClassTypeID] [int] NULL,
	[StationOverridden] [bit] NULL,
	[IsReplenishingParts] [bit] NULL,
	[ProducedInvValueFx] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GLAdjAccountID] [int] NULL,
	[GLAdjAccountClassTypeID] [int] NULL,
 CONSTRAINT [GoodsItemPartLink_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_GoodsItemPartLink_GoodsItemID]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Index_GoodsItemPartLink_GoodsItemID] ON [dbo].[GoodsItemPartLink]
(
	[GoodsItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_GoodsItemPartLink]    Script Date: 5/15/2018 12:06:47 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_GoodsItemPartLink] ON [dbo].[GoodsItemPartLink]
(
	[PartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
