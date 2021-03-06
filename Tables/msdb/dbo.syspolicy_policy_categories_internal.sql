/****** Object:  Table [dbo].[syspolicy_policy_categories_internal]    Script Date: 5/15/2018 12:03:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syspolicy_policy_categories_internal](
	[policy_category_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[mandate_database_subscriptions] [bit] NOT NULL,
 CONSTRAINT [PK_syspolicy_policy_categories] PRIMARY KEY CLUSTERED 
(
	[policy_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_syspolicy_policy_categories_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[syspolicy_policy_categories_internal] ADD  DEFAULT ((1)) FOR [mandate_database_subscriptions]
GO
