/****** Object:  Table [dbo].[sf_ec_order_detail]    Script Date: 5/15/2018 12:01:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_order_detail](
	[wishlist_detail_id] [uniqueidentifier] NULL,
	[weight] [float] NOT NULL,
	[vat_tax_id] [uniqueidentifier] NULL,
	[variant_as_names] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[variant_as_ids] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ttal] [numeric](20, 10) NOT NULL,
	[title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[tax_rate] [numeric](20, 10) NOT NULL,
	[tax_in_price] [tinyint] NOT NULL,
	[tax_class_id] [uniqueidentifier] NOT NULL,
	[sku] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[quantity] [int] NOT NULL,
	[product_id] [uniqueidentifier] NOT NULL,
	[price] [numeric](20, 10) NOT NULL,
	[order_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[is_vat_taxable] [tinyint] NULL,
	[is_us_canada_taxable] [tinyint] NULL,
	[is_shippable] [tinyint] NOT NULL,
	[is_on_sale] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[exchng_rte_price_including_tax] [numeric](20, 10) NOT NULL,
	[exchange_rate_price] [numeric](20, 10) NOT NULL,
	[exchng_rt_bs_prc_including_tax] [numeric](20, 10) NOT NULL,
	[exchange_rate_base_price] [numeric](20, 10) NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[delta_price] [numeric](20, 10) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[base_price] [numeric](20, 10) NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_order_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_c_order_detail_order_id]    Script Date: 5/15/2018 12:01:34 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_order_detail_order_id] ON [dbo].[sf_ec_order_detail]
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
