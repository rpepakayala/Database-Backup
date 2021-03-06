/****** Object:  Table [dbo].[sf_ec_product_variation_detail]    Script Date: 5/15/2018 12:01:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_product_variation_detail](
	[product_variation_id] [uniqueidentifier] NULL,
	[prdct_vration_detail_parent_id] [uniqueidentifier] NOT NULL,
	[product_attribute_value_id] [uniqueidentifier] NULL,
	[product_attribute_id] [uniqueidentifier] NULL,
	[product_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_c_prdct_vrtn_dt_C2E7218A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_prdct_vrtn_dtl_prdct_]    Script Date: 5/15/2018 12:01:37 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_prdct_vrtn_dtl_prdct_] ON [dbo].[sf_ec_product_variation_detail]
(
	[product_variation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
