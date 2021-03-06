/****** Object:  Table [dbo].[sf_ec_product_attribute_link]    Script Date: 5/15/2018 12:01:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_product_attribute_link](
	[product_type_id] [uniqueidentifier] NULL,
	[product_attribute_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_c_prdct_ttrbt_l_B2DD9B31] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_prdct_ttrbt_lnk_prdct]    Script Date: 5/15/2018 12:01:36 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_prdct_ttrbt_lnk_prdct] ON [dbo].[sf_ec_product_attribute_link]
(
	[product_attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_ec_prdct_attr_lnk]    Script Date: 5/15/2018 12:01:36 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_sf_ec_prdct_attr_lnk] ON [dbo].[sf_ec_product_attribute_link]
(
	[app_name] ASC,
	[product_type_id] ASC,
	[product_attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
