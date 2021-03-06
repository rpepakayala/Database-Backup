/****** Object:  Table [dbo].[TransModHistory]    Script Date: 5/15/2018 12:07:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransModHistory](
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
	[GoodsItemID] [int] NULL,
	[GoodsItemClassTypeID] [int] NULL,
	[GoodsItemCode] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PricingLevel] [float] NULL,
	[PricingLevelOverridden] [bit] NULL,
	[DiscountLevel] [float] NULL,
	[DiscountLevelOverridden] [bit] NULL,
	[QuantityApplied] [float] NULL,
	[SortOrder] [int] NULL,
	[FormattedText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListID] [int] NULL,
	[ListText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Units] [int] NULL,
	[UnitsText] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValueType] [int] NULL,
	[ValueAsString] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValueAsFloat] [float] NULL,
	[ValueAsInteger] [int] NULL,
	[ValueAsDateTime] [datetime] NULL,
	[ValueAsBinary] [image] NULL,
	[ValueAsBlob] [image] NULL,
	[ModifierPrice] [float] NULL,
	[ModifierCalcPrice] [float] NULL,
	[ModifierOverriddenPrice] [float] NULL,
	[ModifierIsOverridden] [bit] NULL,
	[MeAndSonsModifierPrice] [float] NULL,
	[InternalNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValueOverridden] [bit] NULL,
 CONSTRAINT [TransModHistory_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
