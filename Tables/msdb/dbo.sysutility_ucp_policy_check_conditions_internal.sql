/****** Object:  Table [dbo].[sysutility_ucp_policy_check_conditions_internal]    Script Date: 5/15/2018 12:03:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysutility_ucp_policy_check_conditions_internal](
	[target_type] [int] NOT NULL,
	[resource_type] [int] NOT NULL,
	[utilization_type] [int] NOT NULL,
	[facet_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[attribute_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[operator_type] [int] NOT NULL,
	[property_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_sysutility_ucp_policy_check_condition_internal_type] PRIMARY KEY CLUSTERED 
(
	[resource_type] ASC,
	[target_type] ASC,
	[utilization_type] ASC,
	[facet_name] ASC,
	[attribute_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
