/****** Object:  Table [dbo].[SKU_Lines]    Script Date: 5/15/2018 11:59:10 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SKU_Lines](
	[____TEST] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___c_ID] [float] NULL,
	[___d_account] [float] NULL,
	[___d_report] [float] NULL,
	[___d_report_G] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___d_SKU_Category] [float] NULL,
	[___d_SKU_ID] [float] NULL,
	[___META_SKU_Lines] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[__constant] [float] NULL,
	[__DG_trigger] [datetime] NULL,
	[__modification] [datetime] NULL,
	[_rpt_col_10] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_rpt_margin_calc] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_rpt_qty] [float] NULL,
	[_rpt_qty_calc] [float] NULL,
	[_SKU_exists] [float] NULL,
	[cost] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[default] [float] NULL,
	[description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[inventory] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[price] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[quantity] [float] NULL,
	[reflex_sku] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[report_level] [float] NULL,
	[report_level_include] [float] NULL,
	[sort] [float] NULL,
	[Accounts::___c_ID] [float] NULL,
	[RFQ_PO_Items_by_report::___c_ID] [float] NULL,
	[SKU_Category::_account_code] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SKU_Category::account_id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SKU_Category::name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SKU_Category::report_level] [float] NULL,
	[SKUs::SKU] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
