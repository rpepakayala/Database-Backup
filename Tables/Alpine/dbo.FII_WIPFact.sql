/****** Object:  Table [dbo].[FII_WIPFact]    Script Date: 5/15/2018 11:58:38 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FII_WIPFact](
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
	[Type] [int] NULL,
 CONSTRAINT [PK_FII_WIPFact] PRIMARY KEY CLUSTERED 
(
	[WIP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
