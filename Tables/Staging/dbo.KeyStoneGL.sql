/****** Object:  Table [dbo].[KeyStoneGL]    Script Date: 5/15/2018 12:06:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[KeyStoneGL](
	[ZW_Franchise_ID] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TransactionDateTime] [date] NULL,
	[OrderID] [int] NULL,
	[OrderKey] [int] NULL,
	[CustomerID] [int] NULL,
	[CustomerKey] [int] NULL,
	[AccountCode] [int] NULL,
	[Amount] [numeric](38, 2) NULL,
	[DescriptionKey] [int] NULL,
	[Closed] [int] NULL,
	[ClosedDate] [date] NULL,
	[Exported] [int] NULL,
	[SubAccountCode] [int] NULL,
	[Taxable] [int] NULL,
	[ModifiedByComputerKey] [int] NULL,
	[ProductID] [int] NULL,
	[OLTP_InsertDate] [datetime2](0) NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[CenterKey] [int] NULL,
	[KeystoneGLFactKey] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UpdateCheckSum] [int] NULL
) ON [PRIMARY]

GO
