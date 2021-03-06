/****** Object:  Table [dbo].[PayrollTaxTable]    Script Date: 5/15/2018 12:06:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PayrollTaxTable](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[AccrualAccountID] [int] NULL,
	[AccrualAccountClassTypeID] [int] NULL,
	[AutoCreateBill] [bit] NULL,
	[BillVendorID] [int] NULL,
	[IsCalculatedAfterFIT] [bit] NULL,
	[LastModifiedByID] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[MarriedTaxRowStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SingleTaxRowStr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxIDNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxTableName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseWithholding] [bit] NULL,
	[WithholdingAllowance] [float] NULL,
	[IsLocalTax] [bit] NULL,
	[IsStateTax] [bit] NULL,
	[LocalityCode] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StateCode] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PayrollTaxTable_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
