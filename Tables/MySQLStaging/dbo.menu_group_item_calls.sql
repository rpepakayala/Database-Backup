/****** Object:  Table [dbo].[menu_group_item_calls]    Script Date: 5/15/2018 12:04:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[menu_group_item_calls](
	[menu_group_item_call_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[menu_group_items_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[module] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[action] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_menu_group_item_calls_menu_group_item_call_id] PRIMARY KEY CLUSTERED 
(
	[menu_group_item_call_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [menu_group_items_id]    Script Date: 5/15/2018 12:04:18 PM ******/
CREATE NONCLUSTERED INDEX [menu_group_items_id] ON [dbo].[menu_group_item_calls]
(
	[menu_group_items_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[menu_group_item_calls] ADD  DEFAULT (NULL) FOR [action]
GO
