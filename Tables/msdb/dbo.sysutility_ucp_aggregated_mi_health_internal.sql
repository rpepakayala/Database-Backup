/****** Object:  Table [dbo].[sysutility_ucp_aggregated_mi_health_internal]    Script Date: 5/15/2018 12:03:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal](
	[mi_count] [int] NOT NULL,
	[mi_healthy_count] [int] NOT NULL,
	[mi_unhealthy_count] [int] NOT NULL,
	[mi_over_utilize_count] [int] NOT NULL,
	[mi_under_utilize_count] [int] NOT NULL,
	[mi_on_over_utilized_computer_count] [int] NOT NULL,
	[mi_on_under_utilized_computer_count] [int] NOT NULL,
	[mi_with_files_on_over_utilized_volume_count] [int] NOT NULL,
	[mi_with_files_on_under_utilized_volume_count] [int] NOT NULL,
	[mi_with_over_utilized_file_count] [int] NOT NULL,
	[mi_with_under_utilized_file_count] [int] NOT NULL,
	[mi_with_over_utilized_processor_count] [int] NOT NULL,
	[mi_with_under_utilized_processor_count] [int] NOT NULL,
	[set_number] [int] NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_healthy_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_unhealthy_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_over_utilize_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_under_utilize_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_on_over_utilized_computer_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_on_under_utilized_computer_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_with_files_on_over_utilized_volume_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_with_files_on_under_utilized_volume_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_with_over_utilized_file_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_with_under_utilized_file_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_with_over_utilized_processor_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [mi_with_under_utilized_processor_count]
ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD  DEFAULT ((0)) FOR [set_number]
GO
