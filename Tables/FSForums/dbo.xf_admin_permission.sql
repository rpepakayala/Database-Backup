/****** Object:  Table [dbo].[xf_admin_permission]    Script Date: 5/15/2018 12:00:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_admin_permission](
	[admin_permission_id] [varbinary](25) NOT NULL,
	[display_order] [bigint] NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
 CONSTRAINT [PK_xf_admin_permission_admin_permission_id] PRIMARY KEY CLUSTERED 
(
	[admin_permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [display_order]    Script Date: 5/15/2018 12:00:14 PM ******/
CREATE NONCLUSTERED INDEX [display_order] ON [dbo].[xf_admin_permission]
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_admin_permission] ADD  DEFAULT ((0)) FOR [display_order]
ALTER TABLE [dbo].[xf_admin_permission] ADD  DEFAULT (0x) FOR [addon_id]
GO
