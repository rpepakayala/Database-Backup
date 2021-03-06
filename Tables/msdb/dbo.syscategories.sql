/****** Object:  Table [dbo].[syscategories]    Script Date: 5/15/2018 12:03:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscategories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_class] [int] NOT NULL,
	[category_type] [tinyint] NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:01 PM ******/
CREATE UNIQUE CLUSTERED INDEX [clust] ON [dbo].[syscategories]
(
	[name] ASC,
	[category_class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
