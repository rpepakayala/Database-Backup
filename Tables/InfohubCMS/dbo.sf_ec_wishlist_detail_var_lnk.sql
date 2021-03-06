/****** Object:  Table [dbo].[sf_ec_wishlist_detail_var_lnk]    Script Date: 5/15/2018 12:01:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_wishlist_detail_var_lnk](
	[wishlist_detail_id] [uniqueidentifier] NULL,
	[product_variation_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_c_wshlst_dtl_vr_20E33F9E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_wshlst_dtl_vr_lnk_wsh]    Script Date: 5/15/2018 12:01:38 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_wshlst_dtl_vr_lnk_wsh] ON [dbo].[sf_ec_wishlist_detail_var_lnk]
(
	[wishlist_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
