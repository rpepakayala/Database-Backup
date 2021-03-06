/****** Object:  Table [dbo].[SKUs]    Script Date: 5/15/2018 11:59:11 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SKUs](
	[___c_ID] [float] NULL,
	[___d_account] [float] NULL,
	[___d_META_SKUs] [float] NULL,
	[__DG_trigger] [datetime] NULL,
	[__modified_last] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_action_parameters] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_action_test] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_emptyTest] [float] NULL,
	[_meta_lookup] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_SKU_base] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[default] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[E_description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[E_status_description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[E_status_test] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[E_status_value] [float] NULL,
	[E_value_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[E_value_test] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[inventory] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[reflex_sku] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[report_title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[royalty_reduction_FII] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[royalty_reduction_NAC] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SKU] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SKU_type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sort] [float] NULL,
	[status] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[template] [float] NULL,
	[valid_from] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[valid_to] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[web_display] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[web_purchase] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
