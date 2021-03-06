/****** Object:  Table [dbo].[PayrollPayItemLink]    Script Date: 5/15/2018 12:06:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PayrollPayItemLink](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[EmployeeID] [int] NULL,
	[PayItemID] [int] NULL,
	[PayItemClassTypeID] [int] NULL,
	[IsSystemPayItem] [bit] NULL,
	[MaritalStatus] [int] NULL,
	[Exemptions] [int] NULL,
	[AdditionalWithholdingType] [int] NULL,
	[AdditionalWithholdingAmount] [float] NULL,
	[AdditionalWithholdingPercentage] [float] NULL,
	[DeductInFirstCheckOfMonth] [bit] NULL,
	[DeductInSecondCheckOfMonth] [bit] NULL,
	[DeductInThirdCheckOfMonth] [bit] NULL,
	[DeductInFourthCheckOfMonth] [bit] NULL,
	[DeductInFifthCheckOfMonth] [bit] NULL,
	[TaxTableID] [int] NULL,
 CONSTRAINT [PayrollPayItemLink_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
