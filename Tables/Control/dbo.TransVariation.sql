/****** Object:  Table [dbo].[TransVariation]    Script Date: 5/15/2018 11:58:59 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransVariation](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[TransactionType] [int] NULL,
	[ParentID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[VariationName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Notes] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortIndex] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[PricingLevel] [float] NULL,
	[PricingLevelOverridden] [bit] NULL,
	[DiscountLevel] [float] NULL,
	[DiscountLevelOverridden] [bit] NULL,
	[HTMLShortFormat] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HTMLLongFormat] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BasePrice] [decimal](18, 4) NULL,
	[DiscountPrice] [decimal](18, 4) NULL,
	[ModifierPrice] [decimal](18, 4) NULL,
	[RawSubTotalPrice] [decimal](18, 4) NULL,
	[RoundingPrice] [decimal](18, 4) NULL,
	[SubTotalPrice] [decimal](18, 4) NULL,
	[TaxesPrice] [decimal](18, 4) NULL,
	[TotalPrice] [decimal](18, 4) NULL,
	[SonsBasePrice] [decimal](18, 4) NULL,
	[SonsDiscountPrice] [decimal](18, 4) NULL,
	[SonsModifierPrice] [decimal](18, 4) NULL,
	[SonsRawSubTotalPrice] [decimal](18, 4) NULL,
	[SonsRoundingPrice] [decimal](18, 4) NULL,
	[SonsSubTotalPrice] [decimal](18, 4) NULL,
	[SonsTaxesPrice] [decimal](18, 4) NULL,
	[SonsTotalPrice] [decimal](18, 4) NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TransVariation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
