/****** Object:  Table [dbo].[PayrollPTO]    Script Date: 5/15/2018 12:06:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PayrollPTO](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[IsEnabled] [bit] NULL,
	[PTOEarningType] [int] NULL,
	[PTOType] [int] NULL,
	[ExpenseAccountID] [int] NULL,
	[ExpenseAccountClassTypeID] [int] NULL,
	[Balance] [float] NULL,
	[IsAccrued] [bit] NULL,
	[AccrualAccountID] [int] NULL,
	[AccrualAccountClassTypeID] [int] NULL,
	[HoursPerYear] [float] NULL,
	[AmountPerPayPeriod] [float] NULL,
	[EstimatedPayOffDate] [datetime] NULL,
	[LastDecreaseDate] [datetime] NULL,
	[LastIncreaseDate] [datetime] NULL,
	[IncludeOverTime] [bit] NULL,
 CONSTRAINT [PayrollPTO_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
