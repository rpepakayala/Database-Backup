/****** Object:  Table [dbo].[SLS_ROYALTY_DISTRIBUTION]    Script Date: 5/15/2018 11:58:39 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SLS_ROYALTY_DISTRIBUTION](
	[RoyaltyPaymentID] [bigint] NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[RoyaltyPeriodID] [bigint] NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[RoyaltyDistributionID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RoyaltyCompanyType] [bigint] NULL,
 CONSTRAINT [PK_SLS_ROYALTY_DISTRIBUTION] PRIMARY KEY CLUSTERED 
(
	[RoyaltyDistributionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

GO
