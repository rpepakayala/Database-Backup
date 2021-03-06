/****** Object:  Table [Royalty].[FII_WIPFact]    Script Date: 5/15/2018 11:59:42 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Royalty].[FII_WIPFact](
	[WIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [bigint] NOT NULL,
	[DateKey] [int] NULL,
	[T_StoreNumber] [int] NULL,
	[Sales_Amt] [money] NULL,
	[Receivables_Amt] [money] NULL,
	[WIP_Amt] [money] NULL,
	[Built_Balance_Amt] [money] NULL,
	[WIP_Built_Balance_Amt] [money] NULL,
	[Voids] [int] NULL,
	[Voids_Amt] [money] NULL,
	[Type] [int] NULL
) ON [PRIMARY]

GO
