/****** Object:  Table [dbo].[job_line_items]    Script Date: 5/15/2018 12:04:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[job_line_items](
	[job_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[job_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sequence] [int] NULL,
	[name] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[product_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[phase_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoice_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[usage_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[recipe_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[device_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[substrate_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[media_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ink_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[width] [numeric](12, 4) NULL,
	[width_unit_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[height] [numeric](12, 4) NULL,
	[height_unit_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[quantity] [int] NULL,
	[unit_cost] [numeric](8, 2) NULL,
	[due_date] [datetime] NULL,
	[proofs_due] [datetime] NULL,
	[production_due_date] [datetime] NULL,
	[production_order] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[shipping_package_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[company_po] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sign_text] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[prod_desc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[desc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[production_minutes] [int] NULL,
	[bg_color] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fg_color] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[assets] [smallint] NULL,
	[file_location] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime] NULL,
	[last_modified_on] [datetime] NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[font] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_job_line_items] PRIMARY KEY CLUSTERED 
(
	[job_line_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_job_line_items_name_includes]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [idx_job_line_items_name_includes] ON [dbo].[job_line_items]
(
	[name] ASC
)
INCLUDE ( 	[job_line_item_id],
	[parent_id],
	[sequence],
	[invoice_line_item_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_JobID]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [IDX_JobID] ON [dbo].[job_line_items]
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_JobLineItems_invoice_line_item_id]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [IDX_JobLineItems_invoice_line_item_id] ON [dbo].[job_line_items]
(
	[invoice_line_item_id] ASC
)
INCLUDE ( 	[job_line_item_id],
	[phase_id],
	[job_id],
	[sequence],
	[parent_id],
	[device_id],
	[shipping_package_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
