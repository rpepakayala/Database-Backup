/****** Object:  Table [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt]    Script Date: 5/15/2018 12:01:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[id2] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_c_prdct_ttrbt_v_0FF78F00] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_prdct_ttrbt_vl_sf_lng]    Script Date: 5/15/2018 12:01:25 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_prdct_ttrbt_vl_sf_lng] ON [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt]  WITH CHECK ADD  CONSTRAINT [ref_sf_c_prdct_ttrbt__57590439] FOREIGN KEY([id])
REFERENCES [dbo].[sf_ec_product_attribute_value] ([id])
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt] CHECK CONSTRAINT [ref_sf_c_prdct_ttrbt__57590439]
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt]  WITH CHECK ADD  CONSTRAINT [ref_sf_c_prdct_ttrbt__655893E8] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_language_data] ([id])
ALTER TABLE [dbo].[sf_c_prdct_ttrbt_vl_sf_lngg_dt] CHECK CONSTRAINT [ref_sf_c_prdct_ttrbt__655893E8]
GO
