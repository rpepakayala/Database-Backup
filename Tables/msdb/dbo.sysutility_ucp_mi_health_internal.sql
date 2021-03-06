/****** Object:  Table [dbo].[sysutility_ucp_mi_health_internal]    Script Date: 5/15/2018 12:03:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysutility_ucp_mi_health_internal](
	[mi_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[is_volume_space_over_utilized] [int] NOT NULL,
	[is_volume_space_under_utilized] [int] NOT NULL,
	[is_computer_processor_over_utilized] [int] NOT NULL,
	[is_computer_processor_under_utilized] [int] NOT NULL,
	[is_file_space_over_utilized] [int] NOT NULL,
	[is_file_space_under_utilized] [int] NOT NULL,
	[is_mi_processor_over_utilized] [int] NOT NULL,
	[is_mi_processor_under_utilized] [int] NOT NULL,
	[is_policy_overridden] [bit] NOT NULL,
	[set_number] [int] NOT NULL,
	[processing_time] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_sysutility_ucp_mi_health_internal_name] PRIMARY KEY CLUSTERED 
(
	[set_number] ASC,
	[mi_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_volume_space_over_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_volume_space_under_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_computer_processor_over_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_computer_processor_under_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_file_space_over_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_file_space_under_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_mi_processor_over_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_mi_processor_under_utilized]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [is_policy_overridden]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT ((0)) FOR [set_number]
ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD  DEFAULT (sysdatetimeoffset()) FOR [processing_time]
GO
