/****** Object:  Table [dbo].[Sales_Actuals_Goals]    Script Date: 5/15/2018 12:01:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sales_Actuals_Goals](
	[STORE] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MONTH] [tinyint] NULL,
	[YEAR] [smallint] NULL,
	[BUSI_MONTH] [smallint] NULL,
	[ACTUAL_SALES] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SALES_GOALS] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
