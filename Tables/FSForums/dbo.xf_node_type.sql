/****** Object:  Table [dbo].[xf_node_type]    Script Date: 5/15/2018 12:00:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_node_type](
	[node_type_id] [varbinary](25) NOT NULL,
	[handler_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[controller_admin_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[datawriter_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[permission_group_id] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[moderator_interface_group_id] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[public_route_prefix] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_node_type_node_type_id] PRIMARY KEY CLUSTERED 
(
	[node_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[xf_node_type] ADD  DEFAULT (N'') FOR [permission_group_id]
ALTER TABLE [dbo].[xf_node_type] ADD  DEFAULT (N'') FOR [moderator_interface_group_id]
GO
