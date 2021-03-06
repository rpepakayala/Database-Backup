/****** Object:  Table [internal].[project_permissions]    Script Date: 5/15/2018 12:06:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[project_permissions](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[sid] [internal].[adt_sid] NOT NULL,
	[object_id] [bigint] NOT NULL,
	[permission_type] [smallint] NOT NULL,
	[is_role] [bit] NOT NULL,
	[is_deny] [bit] NOT NULL,
	[grantor_sid] [internal].[adt_sid] NOT NULL,
 CONSTRAINT [PK_Project_Permissions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Unique_ProjectPermissions]    Script Date: 5/15/2018 12:06:14 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Unique_ProjectPermissions] ON [internal].[project_permissions]
(
	[object_id] ASC,
	[permission_type] ASC,
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [internal].[project_permissions]  WITH CHECK ADD  CONSTRAINT [FK_ProjectPermissions_ObjectId_Projects] FOREIGN KEY([object_id])
REFERENCES [internal].[projects] ([project_id])
ON DELETE CASCADE
ALTER TABLE [internal].[project_permissions] CHECK CONSTRAINT [FK_ProjectPermissions_ObjectId_Projects]
ALTER TABLE [internal].[project_permissions]  WITH CHECK ADD  CONSTRAINT [CK_Project_PermissionType] CHECK  (([permission_type]=(4) OR [permission_type]=(3) OR [permission_type]=(2) OR [permission_type]=(1)))
ALTER TABLE [internal].[project_permissions] CHECK CONSTRAINT [CK_Project_PermissionType]
GO
