/****** Object:  Table [dbo].[xf_warning_action]    Script Date: 5/15/2018 12:00:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_warning_action](
	[warning_action_id] [bigint] IDENTITY(1,1) NOT NULL,
	[points] [int] NOT NULL,
	[action] [varbinary](25) NOT NULL,
	[action_length_type] [varbinary](25) NOT NULL,
	[action_length] [int] NOT NULL,
	[extra_user_group_ids] [varbinary](255) NOT NULL,
 CONSTRAINT [PK_xf_warning_action_warning_action_id] PRIMARY KEY CLUSTERED 
(
	[warning_action_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [points]    Script Date: 5/15/2018 12:00:42 PM ******/
CREATE NONCLUSTERED INDEX [points] ON [dbo].[xf_warning_action]
(
	[points] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
