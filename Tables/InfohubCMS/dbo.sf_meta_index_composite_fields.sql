/****** Object:  Table [dbo].[sf_meta_index_composite_fields]    Script Date: 5/15/2018 12:01:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_meta_index_composite_fields](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_mt_ndx_cmpst_fl_D7A2AAB2] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_mt_ndx_cmpst_fields_val]    Script Date: 5/15/2018 12:01:49 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_mt_ndx_cmpst_fields_val] ON [dbo].[sf_meta_index_composite_fields]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_meta_index_composite_fields]  WITH CHECK ADD  CONSTRAINT [ref_sf_mt_ndx_cmpst_f_55A5FF42] FOREIGN KEY([id])
REFERENCES [dbo].[sf_meta_index] ([id])
ALTER TABLE [dbo].[sf_meta_index_composite_fields] CHECK CONSTRAINT [ref_sf_mt_ndx_cmpst_f_55A5FF42]
GO
