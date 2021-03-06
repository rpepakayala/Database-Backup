/****** Object:  Table [dbo].[sf_ec_product]    Script Date: 5/15/2018 12:01:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_product](
	[weight] [float] NULL,
	[visible] [tinyint] NOT NULL,
	[url_name_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[track_inventory] [int] NOT NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_class_id] [uniqueidentifier] NULL,
	[status] [int] NOT NULL,
	[sku] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sale_start_date] [datetime] NULL,
	[sale_price] [numeric](20, 10) NULL,
	[sale_end_date] [datetime] NULL,
	[publication_date] [datetime] NULL,
	[price] [numeric](20, 10) NOT NULL,
	[ownr] [uniqueidentifier] NULL,
	[out_of_stock_option] [int] NOT NULL,
	[original_owner] [uniqueidentifier] NULL,
	[original_content_id] [uniqueidentifier] NULL,
	[last_modified_by] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[is_vat_taxable] [tinyint] NOT NULL,
	[is_u_s_canada_taxable] [tinyint] NOT NULL,
	[is_shippable] [tinyint] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[inventory] [int] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[expiration_date] [datetime] NULL,
	[description_] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_created] [datetime] NULL,
	[content_state] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[clr_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[associate_buyer_with_role] [uniqueidentifier] NULL,
	[approval_workflow_state_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
	[voa_class] [int] NOT NULL,
 CONSTRAINT [pk_sf_ec_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_products_app_name]    Script Date: 5/15/2018 12:01:36 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_products_app_name] ON [dbo].[sf_ec_product]
(
	[application_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_products_clr_type]    Script Date: 5/15/2018 12:01:36 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_products_clr_type] ON [dbo].[sf_ec_product]
(
	[application_name] ASC,
	[clr_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_products_org_cnt_id]    Script Date: 5/15/2018 12:01:36 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_products_org_cnt_id] ON [dbo].[sf_ec_product]
(
	[original_content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
