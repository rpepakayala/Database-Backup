/****** Object:  Table [dbo].[xf_user_upgrade]    Script Date: 5/15/2018 12:00:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_upgrade](
	[user_upgrade_id] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[display_order] [bigint] NOT NULL,
	[extra_group_ids] [varbinary](255) NOT NULL,
	[recurring] [tinyint] NOT NULL,
	[cost_amount] [decimal](10, 2) NOT NULL,
	[cost_currency] [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[length_amount] [tinyint] NOT NULL,
	[length_unit] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[disabled_upgrade_ids] [varbinary](255) NOT NULL,
	[can_purchase] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_user_upgrade_user_upgrade_id] PRIMARY KEY CLUSTERED 
(
	[user_upgrade_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [display_order]    Script Date: 5/15/2018 12:00:42 PM ******/
CREATE NONCLUSTERED INDEX [display_order] ON [dbo].[xf_user_upgrade]
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_upgrade] ADD  DEFAULT ((0)) FOR [display_order]
ALTER TABLE [dbo].[xf_user_upgrade] ADD  DEFAULT (0x) FOR [extra_group_ids]
ALTER TABLE [dbo].[xf_user_upgrade] ADD  DEFAULT ((0)) FOR [recurring]
ALTER TABLE [dbo].[xf_user_upgrade] ADD  DEFAULT (N'') FOR [length_unit]
ALTER TABLE [dbo].[xf_user_upgrade] ADD  DEFAULT (0x) FOR [disabled_upgrade_ids]
ALTER TABLE [dbo].[xf_user_upgrade] ADD  DEFAULT ((1)) FOR [can_purchase]
GO
