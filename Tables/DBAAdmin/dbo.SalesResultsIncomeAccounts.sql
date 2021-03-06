/****** Object:  Table [dbo].[SalesResultsIncomeAccounts]    Script Date: 5/15/2018 11:59:10 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SalesResultsIncomeAccounts](
	[DatabaseId] [int] NULL,
	[FranchiseName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderId] [int] NULL,
	[OrderProductId] [int] NULL,
	[OrderProductLineItem] [int] NULL,
	[IsActive] [int] NULL,
	[OrderStatusId] [int] NULL,
	[SortAccount] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationId] [int] NULL,
	[LocationName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductionLocationId] [int] NULL,
	[InvoiceNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderCompletionDate] [datetime] NULL,
	[OrderClosedDate] [datetime] NULL,
	[OrderBuiltDate] [datetime] NULL,
	[OrderCreatedDate] [datetime] NULL,
	[CompanyName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GLAcctId] [int] NULL,
	[GL_Account] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVoided] [bit] NULL,
	[OrderFeeTypeId] [int] NULL,
	[CostOfGoodsSold] [decimal](18, 6) NULL,
	[AdditionalCosts] [decimal](18, 6) NULL,
	[Amount] [decimal](18, 6) NULL
) ON [PRIMARY]

GO
