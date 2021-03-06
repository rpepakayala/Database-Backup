/****** Object:  Table [dbo].[PayrollPayItem]    Script Date: 5/15/2018 12:06:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PayrollPayItem](
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
	[EmployerPays] [bit] NULL,
	[ExpenseAccountID] [int] NULL,
	[ExpenseAccountClassTypeID] [int] NULL,
	[ItemName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[W2Box] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[W2Code] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AssociatedDeductionID] [int] NULL,
	[AutoCreateBill] [bit] NULL,
	[BillVendorID] [int] NULL,
	[IsBeforeFICA] [bit] NULL,
	[IsBeforeFIT] [bit] NULL,
	[IsBeforeLIT] [bit] NULL,
	[IsBeforeMedicare] [bit] NULL,
	[IsBeforeSIT] [bit] NULL,
	[IsPreTax] [bit] NULL,
	[IsStandardDeduction] [bit] NULL,
	[MaxDeduction] [float] NULL,
	[MaxWages] [float] NULL,
	[PercentOfWages] [float] NULL,
	[TaxTableID] [int] NULL,
	[IsPaidInWages] [bit] NULL,
	[W2WageOnly] [bit] NULL,
	[IsSUTA] [bit] NULL,
	[IsFUTA] [bit] NULL,
	[State] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WorkersCompCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsRetirementPlan] [bit] NULL,
	[SUTANumber] [varchar](48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmployeeContributes] [bit] NULL,
	[WorkersCompEmployeeRate] [float] NULL,
 CONSTRAINT [PayrollPayItem_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
