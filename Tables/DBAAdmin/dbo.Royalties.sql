/****** Object:  Table [dbo].[Royalties]    Script Date: 5/15/2018 11:59:10 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Royalties](
	[CompanyName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LocationId] [int] NOT NULL,
	[LocationName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RoyaltyGroupId] [int] NOT NULL,
	[RoyaltyGroupName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PlanId] [int] NOT NULL,
	[PlanName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GLAcctId] [int] NOT NULL,
	[GL_Account] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SortAccount] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PaidOnTypeId] [int] NULL,
	[PaidOnTypeDescription] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderId] [int] NOT NULL,
	[OrderCompletionDate] [datetime2](7) NULL,
	[OrderClosedDate] [datetime2](7) NULL,
	[RevenueAmount] [decimal](18, 6) NOT NULL
) ON [PRIMARY]

GO
