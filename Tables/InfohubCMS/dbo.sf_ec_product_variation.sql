/****** Object:  Table [dbo].[sf_ec_product_variation]    Script Date: 5/15/2018 12:01:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_product_variation](
	[variant] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[track_inventory] [int] NOT NULL,
	[sku] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[product_id] [uniqueidentifier] NULL,
	[out_of_stock_option] [int] NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[inventory] [int] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[additional_price] [numeric](20, 10) NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_product_variation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_c_prdct_vrtn_product_id]    Script Date: 5/15/2018 12:01:37 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_prdct_vrtn_product_id] ON [dbo].[sf_ec_product_variation]
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
