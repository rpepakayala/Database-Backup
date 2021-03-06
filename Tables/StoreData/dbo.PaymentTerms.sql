/****** Object:  Table [dbo].[PaymentTerms]    Script Date: 5/15/2018 12:06:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PaymentTerms](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[TermsName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GracePeriod] [int] NULL,
	[InterestRate] [decimal](18, 4) NULL,
	[FeesBasedOnSaleDate] [bit] NULL,
	[CompoundInterest] [bit] NULL,
	[MessageText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatementText0To30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatementText31To60] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatementText61To90] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatementTextOver90] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PromptOnOrderSave] [bit] NULL,
	[TermsType] [int] NULL,
	[StartGraceAtMonthsEnd] [bit] NULL,
	[AllowEarlyPaymentDiscount] [bit] NULL,
	[EarlyPaymentDays] [int] NULL,
	[EarlyPaymentDiscount] [float] NULL,
 CONSTRAINT [PaymentTerms_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
