/****** Object:  Table [dbo].[_zw_Ranking_data]    Script Date: 5/15/2018 12:00:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[_zw_Ranking_data](
	[zw_franchise_id] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Thru_Date] [datetime] NULL,
	[MTDRanking] [int] NULL,
	[MTDSales] [money] NULL,
	[YTDRanking] [int] NULL,
	[YTDSales] [money] NULL
) ON [PRIMARY]

GO
