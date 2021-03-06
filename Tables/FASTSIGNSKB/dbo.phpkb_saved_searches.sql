/****** Object:  Table [dbo].[phpkb_saved_searches]    Script Date: 5/15/2018 11:59:18 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_saved_searches](
	[search_id] [int] IDENTITY(1,1) NOT NULL,
	[search_keyword] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[search_count] [int] NOT NULL,
	[search_results] [int] NOT NULL,
	[search_date_time] [smalldatetime] NOT NULL,
 CONSTRAINT [search_id] PRIMARY KEY CLUSTERED 
(
	[search_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
