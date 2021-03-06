/****** Object:  Table [dbo].[dsol_item_attribute]    Script Date: 5/15/2018 12:04:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[dsol_item_attribute](
	[dsol_item_attribute_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[attribute_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[dsol_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_dsol_item_attribute_dsol_item_attribute_id] PRIMARY KEY CLUSTERED 
(
	[dsol_item_attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [attributes_dsol_item_fkey]    Script Date: 5/15/2018 12:04:04 PM ******/
CREATE NONCLUSTERED INDEX [attributes_dsol_item_fkey] ON [dbo].[dsol_item_attribute]
(
	[attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [dsol_item_attribute_fkey]    Script Date: 5/15/2018 12:04:04 PM ******/
CREATE NONCLUSTERED INDEX [dsol_item_attribute_fkey] ON [dbo].[dsol_item_attribute]
(
	[dsol_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[dsol_item_attribute] ADD  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[dsol_item_attribute] ADD  DEFAULT (NULL) FOR [created_by]
GO
