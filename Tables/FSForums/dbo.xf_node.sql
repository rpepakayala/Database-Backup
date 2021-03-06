/****** Object:  Table [dbo].[xf_node]    Script Date: 5/15/2018 12:00:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_node](
	[node_id] [bigint] IDENTITY(460,1) NOT NULL,
	[title] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[node_name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[node_type_id] [varbinary](25) NOT NULL,
	[parent_node_id] [bigint] NOT NULL,
	[display_order] [bigint] NOT NULL,
	[display_in_list] [tinyint] NOT NULL,
	[lft] [bigint] NOT NULL,
	[rgt] [bigint] NOT NULL,
	[depth] [bigint] NOT NULL,
	[style_id] [bigint] NOT NULL,
	[effective_style_id] [bigint] NOT NULL,
	[breadcrumb_data] [varbinary](max) NULL,
 CONSTRAINT [PK_xf_node_node_id] PRIMARY KEY CLUSTERED 
(
	[node_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_node$node_name_unique] UNIQUE NONCLUSTERED 
(
	[node_name] ASC,
	[node_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [display_in_list]    Script Date: 5/15/2018 12:00:27 PM ******/
CREATE NONCLUSTERED INDEX [display_in_list] ON [dbo].[xf_node]
(
	[display_in_list] ASC,
	[lft] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [display_order]    Script Date: 5/15/2018 12:00:27 PM ******/
CREATE NONCLUSTERED INDEX [display_order] ON [dbo].[xf_node]
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [lft]    Script Date: 5/15/2018 12:00:27 PM ******/
CREATE NONCLUSTERED INDEX [lft] ON [dbo].[xf_node]
(
	[lft] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [parent_node_id]    Script Date: 5/15/2018 12:00:27 PM ******/
CREATE NONCLUSTERED INDEX [parent_node_id] ON [dbo].[xf_node]
(
	[parent_node_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT (NULL) FOR [node_name]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((0)) FOR [parent_node_id]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((1)) FOR [display_order]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((1)) FOR [display_in_list]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((0)) FOR [lft]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((0)) FOR [rgt]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((0)) FOR [depth]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((0)) FOR [style_id]
ALTER TABLE [dbo].[xf_node] ADD  DEFAULT ((0)) FOR [effective_style_id]
GO
