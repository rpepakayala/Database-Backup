/****** Object:  Table [dbo].[coupon_rules_items_substitutes]    Script Date: 5/15/2018 12:04:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[coupon_rules_items_substitutes](
	[coupon_rules_items_substitute_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[coupon_rule_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[table_type] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[table_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[value] [int] NOT NULL,
	[type] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [smallint] NOT NULL,
 CONSTRAINT [PK_coupon_rules_items_substitutes_coupon_rules_items_substitute_id] PRIMARY KEY CLUSTERED 
(
	[coupon_rules_items_substitute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[coupon_rules_items_substitutes] ADD  DEFAULT (NULL) FOR [table_type]
ALTER TABLE [dbo].[coupon_rules_items_substitutes] ADD  DEFAULT (NULL) FOR [type]
ALTER TABLE [dbo].[coupon_rules_items_substitutes] ADD  DEFAULT ((1)) FOR [active]
GO
