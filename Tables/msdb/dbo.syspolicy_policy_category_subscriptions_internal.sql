/****** Object:  Table [dbo].[syspolicy_policy_category_subscriptions_internal]    Script Date: 5/15/2018 12:03:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syspolicy_policy_category_subscriptions_internal](
	[policy_category_subscription_id] [int] IDENTITY(1,1) NOT NULL,
	[target_type] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[target_object] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[policy_category_id] [int] NOT NULL,
 CONSTRAINT [PK_syspolicy_policy_category_subscriptions] PRIMARY KEY CLUSTERED 
(
	[policy_category_subscription_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [UX_syspolicy_policy_category_subscriptions]    Script Date: 5/15/2018 12:03:10 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_syspolicy_policy_category_subscriptions] ON [dbo].[syspolicy_policy_category_subscriptions_internal]
(
	[policy_category_id] ASC,
	[target_object] ASC,
	[target_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[syspolicy_policy_category_subscriptions_internal]  WITH CHECK ADD  CONSTRAINT [FK_syspolicy_policy_category_subscriptions_syspolicy_policy_categories] FOREIGN KEY([policy_category_id])
REFERENCES [dbo].[syspolicy_policy_categories_internal] ([policy_category_id])
ON DELETE CASCADE
ALTER TABLE [dbo].[syspolicy_policy_category_subscriptions_internal] CHECK CONSTRAINT [FK_syspolicy_policy_category_subscriptions_syspolicy_policy_categories]
GO
