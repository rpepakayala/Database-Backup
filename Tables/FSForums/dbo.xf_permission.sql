/****** Object:  Table [dbo].[xf_permission]    Script Date: 5/15/2018 12:00:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_permission](
	[permission_id] [varbinary](25) NOT NULL,
	[permission_group_id] [varbinary](25) NOT NULL,
	[permission_type] [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[interface_group_id] [varbinary](50) NOT NULL,
	[depend_permission_id] [varbinary](25) NOT NULL,
	[display_order] [bigint] NOT NULL,
	[default_value] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[default_value_int] [int] NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
 CONSTRAINT [PK_xf_permission_permission_id] PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC,
	[permission_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [display_order]    Script Date: 5/15/2018 12:00:28 PM ******/
CREATE NONCLUSTERED INDEX [display_order] ON [dbo].[xf_permission]
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_permission] ADD  DEFAULT (0x) FOR [addon_id]
GO
