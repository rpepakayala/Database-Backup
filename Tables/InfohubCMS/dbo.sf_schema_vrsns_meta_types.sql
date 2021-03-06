/****** Object:  Table [dbo].[sf_schema_vrsns_meta_types]    Script Date: 5/15/2018 12:02:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_schema_vrsns_meta_types](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_schema_vrsns_meta_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_schm_vrsns_mt_types_val]    Script Date: 5/15/2018 12:02:02 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_schm_vrsns_mt_types_val] ON [dbo].[sf_schema_vrsns_meta_types]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_schema_vrsns_meta_types]  WITH CHECK ADD  CONSTRAINT [ref_sf_schm_vrsns_mt__BF84E03B] FOREIGN KEY([id])
REFERENCES [dbo].[sf_schema_vrsns] ([id])
ALTER TABLE [dbo].[sf_schema_vrsns_meta_types] CHECK CONSTRAINT [ref_sf_schm_vrsns_mt__BF84E03B]
GO
