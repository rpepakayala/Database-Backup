/****** Object:  Table [dbo].[TransVariationHistory]    Script Date: 5/15/2018 12:07:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransVariationHistory](
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
	[VariationName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortIndex] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[PricingLevel] [float] NULL,
	[PricingLevelOverridden] [bit] NULL,
	[DiscountLevel] [float] NULL,
	[DiscountLevelOverridden] [bit] NULL,
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
	[TaxablePrice] [float] NULL,
	[SonsTaxablePrice] [float] NULL,
 CONSTRAINT [TransVariationHistory_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
