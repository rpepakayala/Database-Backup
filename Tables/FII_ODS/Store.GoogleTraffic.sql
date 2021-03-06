/****** Object:  Table [Store].[GoogleTraffic]    Script Date: 5/15/2018 11:59:44 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[GoogleTraffic](
	[ReportingPeriod] [date] NOT NULL,
	[WebNumber] [int] NOT NULL,
	[Visits] [int] NOT NULL,
	[PageViews] [int] NOT NULL,
	[BounceRate] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_GoogleTraffic] PRIMARY KEY CLUSTERED 
(
	[ReportingPeriod] ASC,
	[WebNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
