/****** Object:  Table [dbo].[DailyAmounts_05082018]    Script Date: 5/15/2018 11:59:03 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DailyAmounts_05082018](
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ReportType] [int] NOT NULL,
	[ReportItem] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrentAmount] [decimal](18, 6) NULL,
	[LastUpdate] [datetime] NOT NULL,
	[UpdatedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Currency] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
