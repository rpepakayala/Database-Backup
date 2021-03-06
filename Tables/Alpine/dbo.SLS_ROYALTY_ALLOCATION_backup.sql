/****** Object:  Table [dbo].[SLS_ROYALTY_ALLOCATION_backup]    Script Date: 5/15/2018 11:58:39 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SLS_ROYALTY_ALLOCATION_backup](
	[AllocationID] [bigint] IDENTITY(1,1) NOT NULL,
	[RoyaltyReportID] [bigint] NULL,
	[RoyaltyAllocationType] [bigint] NULL,
	[AllocationAmount] [numeric](18, 2) NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[FIIPercent] [decimal](18, 4) NULL,
	[NACPercent] [decimal](18, 4) NULL,
	[FIIamount] [money] NULL,
	[NACamount] [money] NULL,
	[Comments] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
