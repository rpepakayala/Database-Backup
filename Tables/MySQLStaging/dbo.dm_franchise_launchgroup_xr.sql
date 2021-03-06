/****** Object:  Table [dbo].[dm_franchise_launchgroup_xr]    Script Date: 5/15/2018 12:04:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[dm_franchise_launchgroup_xr](
	[franchise_launchgroup_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[launch_group_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[launch_status_cd] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[legacy_store_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[default_product] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ods_product_count] [int] NULL,
	[migrated_product_count] [int] NULL,
	[ods_account_count] [int] NULL,
	[migrated_account_count] [int] NULL,
	[ods_contact_count] [int] NULL,
	[migrated_contact_count] [int] NULL,
	[ods_job_count] [int] NULL,
	[migrated_job_count] [int] NULL,
 CONSTRAINT [PK_dm_franchise_launchgroup_xr_franchise_launchgroup_id] PRIMARY KEY CLUSTERED 
(
	[franchise_launchgroup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [default_product]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [default_product] ON [dbo].[dm_franchise_launchgroup_xr]
(
	[default_product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [launch_group_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [launch_group_id] ON [dbo].[dm_franchise_launchgroup_xr]
(
	[launch_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [legacy_store_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [legacy_store_id] ON [dbo].[dm_franchise_launchgroup_xr]
(
	[legacy_store_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [default_product]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [ods_product_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [migrated_product_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [ods_account_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [migrated_account_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [ods_contact_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [migrated_contact_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [ods_job_count]
ALTER TABLE [dbo].[dm_franchise_launchgroup_xr] ADD  DEFAULT (NULL) FOR [migrated_job_count]
GO
