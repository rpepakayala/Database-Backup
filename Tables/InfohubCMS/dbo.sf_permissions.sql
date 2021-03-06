/****** Object:  Table [dbo].[sf_permissions]    Script Date: 5/15/2018 12:01:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_permissions](
	[id] [uniqueidentifier] NOT NULL,
	[set_name] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[object_id] [uniqueidentifier] NOT NULL,
	[principal_id] [uniqueidentifier] NOT NULL,
	[grnt] [int] NOT NULL,
	[deny] [int] NOT NULL,
	[app_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_permissions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_permission_setname]    Script Date: 5/15/2018 12:01:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_permission_setname] ON [dbo].[sf_permissions]
(
	[set_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_permissions]    Script Date: 5/15/2018 12:01:57 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_sf_permissions] ON [dbo].[sf_permissions]
(
	[object_id] ASC,
	[principal_id] ASC,
	[app_name] ASC,
	[set_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
