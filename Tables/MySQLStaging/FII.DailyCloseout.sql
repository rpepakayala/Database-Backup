/****** Object:  Table [FII].[DailyCloseout]    Script Date: 5/15/2018 12:04:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[DailyCloseout](
	[Franchise_Id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StoreNumber] [bigint] NULL,
	[CloseDate] [date] NOT NULL,
	[WIP] [decimal](38, 2) NULL,
	[Placed] [decimal](38, 2) NULL,
	[AR] [decimal](38, 2) NULL,
	[Built] [decimal](38, 2) NULL,
 CONSTRAINT [PK_DailyCloseout] PRIMARY KEY CLUSTERED 
(
	[Franchise_Id] ASC,
	[CloseDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
