/****** Object:  Table [dbo].[FranchiseFact_Backup_04112018]    Script Date: 5/15/2018 11:59:51 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FranchiseFact_Backup_04112018](
	[StoreKey] [int] NULL,
	[DateKey] [int] NULL,
	[T_StoreNumber] [int] NULL,
	[Sales_Amt] [money] NULL,
	[Receivables_Amt] [money] NULL,
	[WIP_Amt] [money] NULL,
	[Built_Balance_Amt] [money] NULL,
	[WIP_Built_Balance_Amt] [money] NULL,
	[Voids] [int] NULL,
	[Voids_Amt] [money] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NULL
) ON [PRIMARY]

GO
