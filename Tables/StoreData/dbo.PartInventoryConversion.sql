/****** Object:  Table [dbo].[PartInventoryConversion]    Script Date: 5/15/2018 12:06:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PartInventoryConversion](
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
	[IsAutomatic] [bit] NULL,
	[IsDefault] [bit] NULL,
	[ConversionFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConsumptionFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InclusionFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitID] [int] NULL,
	[UnitType] [int] NULL,
 CONSTRAINT [PartInventoryConversion_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_PartInventoryConversion]    Script Date: 5/15/2018 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [Index_PartInventoryConversion] ON [dbo].[PartInventoryConversion]
(
	[PartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_PartInventoryConversion_UnitID]    Script Date: 5/15/2018 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [Index_PartInventoryConversion_UnitID] ON [dbo].[PartInventoryConversion]
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
