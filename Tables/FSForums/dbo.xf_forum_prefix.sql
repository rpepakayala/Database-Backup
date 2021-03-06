/****** Object:  Table [dbo].[xf_forum_prefix]    Script Date: 5/15/2018 12:00:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_forum_prefix](
	[node_id] [bigint] NOT NULL,
	[prefix_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_forum_prefix_node_id] PRIMARY KEY CLUSTERED 
(
	[node_id] ASC,
	[prefix_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [prefix_id]    Script Date: 5/15/2018 12:00:22 PM ******/
CREATE NONCLUSTERED INDEX [prefix_id] ON [dbo].[xf_forum_prefix]
(
	[prefix_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
