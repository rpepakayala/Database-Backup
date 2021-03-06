/****** Object:  Table [dbo].[sf_pg_nd_prmssnst_bjct_ttl_rs_]    Script Date: 5/15/2018 12:01:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_pg_nd_prmssnst_bjct_ttl_rs_](
	[id] [uniqueidentifier] NOT NULL,
	[mapkey] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_pg_nd_prmssnst__6762D058] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[mapkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_pg_nd_prmssnst_bjct_ttl]    Script Date: 5/15/2018 12:01:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_pg_nd_prmssnst_bjct_ttl] ON [dbo].[sf_pg_nd_prmssnst_bjct_ttl_rs_]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_pg_nd_prmssnst_bjct_ttl_rs_]  WITH CHECK ADD  CONSTRAINT [ref_sf_pg_nd_prmssnst_5220774D] FOREIGN KEY([id])
REFERENCES [dbo].[sf_page_node] ([id])
ALTER TABLE [dbo].[sf_pg_nd_prmssnst_bjct_ttl_rs_] CHECK CONSTRAINT [ref_sf_pg_nd_prmssnst_5220774D]
GO
