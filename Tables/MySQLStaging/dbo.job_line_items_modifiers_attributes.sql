/****** Object:  Table [dbo].[job_line_items_modifiers_attributes]    Script Date: 5/15/2018 12:04:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[job_line_items_modifiers_attributes](
	[job_line_item_modifier_attribute_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[job_line_item_modifier_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[modifiers_attributes_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[attribute_name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[value] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[option_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[option_name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_job_line_items_modifiers_attributes_job_line_item_modifier_attribute_id] PRIMARY KEY CLUSTERED 
(
	[job_line_item_modifier_attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [job_line_item_modifier_id]    Script Date: 5/15/2018 12:04:15 PM ******/
CREATE NONCLUSTERED INDEX [job_line_item_modifier_id] ON [dbo].[job_line_items_modifiers_attributes]
(
	[job_line_item_modifier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [modifiers_attributes_id]    Script Date: 5/15/2018 12:04:15 PM ******/
CREATE NONCLUSTERED INDEX [modifiers_attributes_id] ON [dbo].[job_line_items_modifiers_attributes]
(
	[modifiers_attributes_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [option_id]    Script Date: 5/15/2018 12:04:15 PM ******/
CREATE NONCLUSTERED INDEX [option_id] ON [dbo].[job_line_items_modifiers_attributes]
(
	[option_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[job_line_items_modifiers_attributes] ADD  DEFAULT (NULL) FOR [attribute_name]
ALTER TABLE [dbo].[job_line_items_modifiers_attributes] ADD  DEFAULT (NULL) FOR [value]
ALTER TABLE [dbo].[job_line_items_modifiers_attributes] ADD  DEFAULT (NULL) FOR [option_id]
ALTER TABLE [dbo].[job_line_items_modifiers_attributes] ADD  DEFAULT (NULL) FOR [option_name]
GO
