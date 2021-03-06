/****** Object:  Table [dbo].[PayrollPaycheckPayItem]    Script Date: 5/15/2018 12:06:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PayrollPaycheckPayItem](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[PaycheckID] [int] NULL,
	[EmployeeID] [int] NULL,
	[PayItemID] [int] NULL,
	[PayItemClassTypeID] [int] NULL,
	[Amount] [float] NULL,
	[AmountOV] [bit] NULL,
	[CalcAmount] [float] NULL,
	[OVAmount] [float] NULL,
	[IsMissed] [bit] NULL,
	[PayItemType] [int] NULL,
	[PayItemText] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Hours] [float] NULL,
	[ShowOnPaycheck] [bit] NULL,
	[PayrollID] [int] NULL,
	[PayrollClassTypeID] [int] NULL,
 CONSTRAINT [PayrollPaycheckPayItem_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
