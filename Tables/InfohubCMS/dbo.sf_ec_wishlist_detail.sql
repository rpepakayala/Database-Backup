/****** Object:  Table [dbo].[sf_ec_wishlist_detail]    Script Date: 5/15/2018 12:01:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_wishlist_detail](
	[weight] [float] NOT NULL,
	[variant_as_names] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[variant_as_ids] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ttal] [numeric](20, 10) NOT NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_rate] [numeric](20, 10) NOT NULL,
	[tax_in_price] [tinyint] NOT NULL,
	[tax_class_id] [uniqueidentifier] NULL,
	[sku] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[quantity_got] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[purchase_status] [int] NOT NULL,
	[product_id] [uniqueidentifier] NOT NULL,
	[price] [numeric](20, 10) NOT NULL,
	[wishlist_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[is_on_sale] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[delta_price] [numeric](20, 10) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[base_price] [numeric](20, 10) NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_ec_wishlist_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_c_wshlst_dtl_wshlist_id]    Script Date: 5/15/2018 12:01:38 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_wshlst_dtl_wshlist_id] ON [dbo].[sf_ec_wishlist_detail]
(
	[wishlist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
