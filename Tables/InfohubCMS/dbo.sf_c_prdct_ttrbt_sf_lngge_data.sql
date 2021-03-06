/****** Object:  Table [dbo].[sf_c_prdct_ttrbt_sf_lngge_data]    Script Date: 5/15/2018 12:01:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_c_prdct_ttrbt_sf_lngge_data](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[id2] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_c_prdct_ttrbt_s_21742277] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_prdct_ttrbt_sf_lngg_d]    Script Date: 5/15/2018 12:01:25 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_prdct_ttrbt_sf_lngg_d] ON [dbo].[sf_c_prdct_ttrbt_sf_lngge_data]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_sf_lngge_data]  WITH CHECK ADD  CONSTRAINT [ref_sf_c_prdct_ttrbt__3AF3429A] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_language_data] ([id])
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_sf_lngge_data] CHECK CONSTRAINT [ref_sf_c_prdct_ttrbt__3AF3429A]
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_sf_lngge_data]  WITH CHECK ADD  CONSTRAINT [ref_sf_c_prdct_ttrbt__9F4494B4] FOREIGN KEY([id])
REFERENCES [dbo].[sf_ec_product_attribute] ([id])
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_sf_lngge_data] CHECK CONSTRAINT [ref_sf_c_prdct_ttrbt__9F4494B4]
GO
