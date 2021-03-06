/****** Object:  Table [dbo].[sysutility_ucp_health_policies_internal]    Script Date: 5/15/2018 12:03:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysutility_ucp_health_policies_internal](
	[health_policy_id] [int] IDENTITY(1,1) NOT NULL,
	[policy_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[rollup_object_urn] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[rollup_object_type] [int] NOT NULL,
	[target_type] [int] NOT NULL,
	[resource_type] [int] NOT NULL,
	[utilization_type] [int] NOT NULL,
	[utilization_threshold] [float] NOT NULL,
	[is_global_policy] [bit] NULL,
 CONSTRAINT [PK_sysutility_ucp_policies_internal_id] PRIMARY KEY CLUSTERED 
(
	[health_policy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [NCI_sysutility_resource_health_policies_urn_types]    Script Date: 5/15/2018 12:03:16 PM ******/
CREATE NONCLUSTERED INDEX [NCI_sysutility_resource_health_policies_urn_types] ON [dbo].[sysutility_ucp_health_policies_internal]
(
	[rollup_object_type] ASC,
	[target_type] ASC,
	[resource_type] ASC,
	[utilization_type] ASC,
	[policy_name] ASC
)
INCLUDE ( 	[rollup_object_urn]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[sysutility_ucp_health_policies_internal] ADD  DEFAULT ((0)) FOR [is_global_policy]
GO
