/****** Object:  Table [dbo].[devices]    Script Date: 5/15/2018 12:04:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[devices](
	[device_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [smallint] NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_on] [datetime] NOT NULL,
	[device_type_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[color] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[corporate_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[primary_device] [tinyint] NOT NULL,
	[default_placeholder] [smallint] NOT NULL,
	[default_unit] [int] NULL,
	[job_est_prod_speed] [int] NULL,
	[max_print_width] [int] NULL,
	[min_print_width] [int] NULL,
	[max_substrate_width] [int] NULL,
	[min_substrate_width] [int] NULL,
	[max_resolution] [int] NULL,
	[number_printheads] [int] NULL,
	[max_mfg_prod_speed] [int] NULL,
 CONSTRAINT [PK_devices_device_id] PRIMARY KEY CLUSTERED 
(
	[device_id] ASC,
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [corporate_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [corporate_id] ON [dbo].[devices]
(
	[corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [default_placeholder]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [default_placeholder] ON [dbo].[devices]
(
	[default_placeholder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [device_type_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [device_type_id] ON [dbo].[devices]
(
	[device_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [entity_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [entity_id] ON [dbo].[devices]
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_devices_franchise_id_active_includes]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [idx_devices_franchise_id_active_includes] ON [dbo].[devices]
(
	[franchise_id] ASC,
	[active] ASC
)
INCLUDE ( 	[name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [entity_id]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [description]
ALTER TABLE [dbo].[devices] ADD  DEFAULT ((1)) FOR [active]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (getdate()) FOR [last_modified_on]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [corporate_id]
ALTER TABLE [dbo].[devices] ADD  DEFAULT ((0)) FOR [primary_device]
ALTER TABLE [dbo].[devices] ADD  DEFAULT ((0)) FOR [default_placeholder]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [default_unit]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [job_est_prod_speed]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [max_print_width]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [min_print_width]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [max_substrate_width]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [min_substrate_width]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [max_resolution]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [number_printheads]
ALTER TABLE [dbo].[devices] ADD  DEFAULT (NULL) FOR [max_mfg_prod_speed]
GO
