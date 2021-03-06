/****** Object:  Table [dbo].[audit_collection_nodes]    Script Date: 5/15/2018 12:00:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[audit_collection_nodes](
	[concept_id] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[node_id] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[lastcollected_clienttime] [datetime] NULL,
	[lastcollected_servertime] [datetime] NULL,
	[trg_action] [char](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[trg_date] [datetime] NULL
) ON [PRIMARY]

/****** Object:  Index [idx_audit_collection_nodes_lastcollected_clienttime]    Script Date: 5/15/2018 12:00:46 PM ******/
CREATE NONCLUSTERED INDEX [idx_audit_collection_nodes_lastcollected_clienttime] ON [dbo].[audit_collection_nodes]
(
	[lastcollected_clienttime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
