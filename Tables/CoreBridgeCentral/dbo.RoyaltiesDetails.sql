/****** Object:  Table [dbo].[RoyaltiesDetails]    Script Date: 5/15/2018 11:59:04 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RoyaltiesDetails](
	[ID] [int] NOT NULL,
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
	[OrderCompletionDate] [datetimeoffset](7) NULL,
	[OrderClosedDate] [datetimeoffset](7) NULL,
	[RevenueAmount] [decimal](18, 6) NOT NULL,
	[Currency] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_RoyaltiesDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
