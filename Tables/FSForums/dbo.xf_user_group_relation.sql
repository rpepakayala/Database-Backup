/****** Object:  Table [dbo].[xf_user_group_relation]    Script Date: 5/15/2018 12:00:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_group_relation](
	[user_id] [bigint] NOT NULL,
	[user_group_id] [bigint] NOT NULL,
	[is_primary] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_user_group_relation_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[user_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [user_group_id_is_primary]    Script Date: 5/15/2018 12:00:40 PM ******/
CREATE NONCLUSTERED INDEX [user_group_id_is_primary] ON [dbo].[xf_user_group_relation]
(
	[user_group_id] ASC,
	[is_primary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
