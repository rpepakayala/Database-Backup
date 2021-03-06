/****** Object:  Table [dbo].[xf_user_group_change]    Script Date: 5/15/2018 12:00:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_group_change](
	[user_id] [bigint] NOT NULL,
	[change_key] [varbinary](50) NOT NULL,
	[group_ids] [varbinary](255) NOT NULL,
 CONSTRAINT [PK_xf_user_group_change_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[change_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [change_key]    Script Date: 5/15/2018 12:00:40 PM ******/
CREATE NONCLUSTERED INDEX [change_key] ON [dbo].[xf_user_group_change]
(
	[change_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
