/****** Object:  Table [dbo].[xf_user_change_temp]    Script Date: 5/15/2018 12:00:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_change_temp](
	[user_change_temp_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[change_key] [varbinary](50) NULL,
	[action_type] [varbinary](50) NOT NULL,
	[action_modifier] [varbinary](255) NULL,
	[new_value] [varbinary](max) NULL,
	[old_value] [varbinary](max) NULL,
	[create_date] [bigint] NULL,
	[expiry_date] [bigint] NULL,
 CONSTRAINT [PK_xf_user_change_temp_user_change_temp_id] PRIMARY KEY CLUSTERED 
(
	[user_change_temp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_user_change_temp$user_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC,
	[change_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [change_key]    Script Date: 5/15/2018 12:00:39 PM ******/
CREATE NONCLUSTERED INDEX [change_key] ON [dbo].[xf_user_change_temp]
(
	[change_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [expiry_date]    Script Date: 5/15/2018 12:00:39 PM ******/
CREATE NONCLUSTERED INDEX [expiry_date] ON [dbo].[xf_user_change_temp]
(
	[expiry_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_change_temp] ADD  DEFAULT (NULL) FOR [change_key]
ALTER TABLE [dbo].[xf_user_change_temp] ADD  DEFAULT (NULL) FOR [action_modifier]
ALTER TABLE [dbo].[xf_user_change_temp] ADD  DEFAULT (NULL) FOR [create_date]
ALTER TABLE [dbo].[xf_user_change_temp] ADD  DEFAULT (NULL) FOR [expiry_date]
GO
