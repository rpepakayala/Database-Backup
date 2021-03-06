/****** Object:  Table [dbo].[ProductTaxabilityCode]    Script Date: 5/15/2018 12:06:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductTaxabilityCode](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[TaxCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsTaxExempt] [bit] NULL,
	[AvaTaxCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsFullyTaxed] [bit] NULL,
	[TaxableAmountFormula] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxableCalculationType] [int] NULL,
	[TaxableCalculationTypeText] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [ProductTaxabilityCode_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
