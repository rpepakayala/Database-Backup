/****** Object:  Table [dbo].[permissions]    Script Date: 5/15/2018 12:04:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[permissions](
	[permission_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[role_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[users_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[menu_group_items_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[value] [smallint] NOT NULL,
 CONSTRAINT [PK_permissions_permission_id] PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[permissions]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [menu_group_items_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [menu_group_items_id] ON [dbo].[permissions]
(
	[menu_group_items_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [role_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [role_id] ON [dbo].[permissions]
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [users_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [users_id] ON [dbo].[permissions]
(
	[users_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[permissions] ADD  DEFAULT (NULL) FOR [role_id]
ALTER TABLE [dbo].[permissions] ADD  DEFAULT (NULL) FOR [users_id]
ALTER TABLE [dbo].[permissions] ADD  DEFAULT (NULL) FOR [franchise_id]
ALTER TABLE [dbo].[permissions] ADD  DEFAULT ((0)) FOR [value]
GO
