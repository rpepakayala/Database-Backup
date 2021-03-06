/****** Object:  Table [dbo].[xf_permission_combination]    Script Date: 5/15/2018 12:00:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_permission_combination](
	[permission_combination_id] [bigint] IDENTITY(141,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[user_group_list] [varbinary](max) NOT NULL,
	[cache_value] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_permission_combination_permission_combination_id] PRIMARY KEY CLUSTERED 
(
	[permission_combination_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:28 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_permission_combination]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
