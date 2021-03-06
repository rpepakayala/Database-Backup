/****** Object:  Table [dbo].[job_line_items_modifiers]    Script Date: 5/15/2018 12:04:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[job_line_items_modifiers](
	[job_line_item_modifier_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[job_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[modifier_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[invoice_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[quantity] [int] NULL,
	[unit_cost] [decimal](8, 2) NULL,
	[price_type_id] [int] NULL,
	[manual_price] [smallint] NULL,
	[overall_minimum] [decimal](8, 2) NULL,
	[per_piece_minimum] [decimal](8, 2) NULL,
	[per_modifier_minimum] [decimal](8, 2) NULL,
	[double_minimum] [smallint] NULL,
	[desc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime2](0) NULL,
	[last_modified_on] [datetime2](0) NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_job_line_items_modifiers_job_line_item_modifier_id] PRIMARY KEY CLUSTERED 
(
	[job_line_item_modifier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [invoice_line_item_id]    Script Date: 5/15/2018 12:04:15 PM ******/
CREATE NONCLUSTERED INDEX [invoice_line_item_id] ON [dbo].[job_line_items_modifiers]
(
	[invoice_line_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [job_line_item_id]    Script Date: 5/15/2018 12:04:15 PM ******/
CREATE NONCLUSTERED INDEX [job_line_item_id] ON [dbo].[job_line_items_modifiers]
(
	[job_line_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [modifier_id]    Script Date: 5/15/2018 12:04:15 PM ******/
CREATE NONCLUSTERED INDEX [modifier_id] ON [dbo].[job_line_items_modifiers]
(
	[modifier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[job_line_items_modifiers] ADD  CONSTRAINT [DF_job_line_items_modifiers_manual_price]  DEFAULT ((0)) FOR [manual_price]
GO
