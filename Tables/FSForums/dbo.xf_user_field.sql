/****** Object:  Table [dbo].[xf_user_field]    Script Date: 5/15/2018 12:00:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_field](
	[field_id] [varbinary](25) NOT NULL,
	[display_group] [nvarchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[display_order] [bigint] NOT NULL,
	[field_type] [nvarchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[field_choices] [varbinary](max) NOT NULL,
	[match_type] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[match_regex] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[match_callback_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[match_callback_method] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[max_length] [bigint] NOT NULL,
	[required] [tinyint] NOT NULL,
	[show_registration] [tinyint] NOT NULL,
	[user_editable] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[viewable_profile] [smallint] NOT NULL,
	[viewable_message] [smallint] NOT NULL,
	[display_template] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[moderator_editable] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_user_field_field_id] PRIMARY KEY CLUSTERED 
(
	[field_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [display_group_order]    Script Date: 5/15/2018 12:00:39 PM ******/
CREATE NONCLUSTERED INDEX [display_group_order] ON [dbo].[xf_user_field]
(
	[display_group] ASC,
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'personal') FOR [display_group]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((1)) FOR [display_order]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'textbox') FOR [field_type]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'none') FOR [match_type]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'') FOR [match_regex]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'') FOR [match_callback_class]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'') FOR [match_callback_method]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((0)) FOR [max_length]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((0)) FOR [required]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((0)) FOR [show_registration]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT (N'yes') FOR [user_editable]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((1)) FOR [viewable_profile]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((0)) FOR [viewable_message]
ALTER TABLE [dbo].[xf_user_field] ADD  DEFAULT ((0)) FOR [moderator_editable]
GO
