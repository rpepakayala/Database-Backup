/****** Object:  Table [dbo].[xf_stats_daily]    Script Date: 5/15/2018 12:00:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_stats_daily](
	[stats_date] [bigint] NOT NULL,
	[stats_type] [varbinary](25) NOT NULL,
	[counter] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_stats_daily_stats_date] PRIMARY KEY CLUSTERED 
(
	[stats_date] ASC,
	[stats_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
