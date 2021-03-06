/****** Object:  Table [dbo].[franchise_tax_item]    Script Date: 5/15/2018 12:04:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[franchise_tax_item](
	[franchise_tax_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_tax_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[item_name] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[item_description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_tax_rate] [decimal](12, 5) NULL,
	[item_active_flag] [smallint] NULL,
	[created_on] [datetime2](0) NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_franchise_tax_item_franchise_tax_item_id] PRIMARY KEY CLUSTERED 
(
	[franchise_tax_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [franchise_tax_item_fkey]    Script Date: 5/15/2018 12:04:10 PM ******/
CREATE NONCLUSTERED INDEX [franchise_tax_item_fkey] ON [dbo].[franchise_tax_item]
(
	[franchise_tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[franchise_tax_item] ADD  DEFAULT (NULL) FOR [item_description]
ALTER TABLE [dbo].[franchise_tax_item] ADD  DEFAULT (NULL) FOR [item_tax_rate]
ALTER TABLE [dbo].[franchise_tax_item] ADD  DEFAULT (NULL) FOR [item_active_flag]
ALTER TABLE [dbo].[franchise_tax_item] ADD  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[franchise_tax_item] ADD  DEFAULT (NULL) FOR [created_by]
GO
