/****** Object:  Table [dbo].[systargetservergroupmembers]    Script Date: 5/15/2018 12:03:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[systargetservergroupmembers](
	[servergroup_id] [int] NOT NULL,
	[server_id] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:12 PM ******/
CREATE UNIQUE CLUSTERED INDEX [clust] ON [dbo].[systargetservergroupmembers]
(
	[servergroup_id] ASC,
	[server_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc1]    Script Date: 5/15/2018 12:03:12 PM ******/
CREATE NONCLUSTERED INDEX [nc1] ON [dbo].[systargetservergroupmembers]
(
	[server_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
