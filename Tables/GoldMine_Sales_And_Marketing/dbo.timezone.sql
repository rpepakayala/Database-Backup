/****** Object:  Table [dbo].[timezone]    Script Date: 5/15/2018 12:01:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[timezone](
	[city] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[st] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[zip] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AC] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIPS] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[county] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pref] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tz] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dst] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
