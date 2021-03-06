/****** Object:  Table [dbo].[xf_session_activity]    Script Date: 5/15/2018 12:00:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_session_activity](
	[user_id] [bigint] NOT NULL,
	[controller_name] [varbinary](50) NOT NULL,
	[controller_action] [varbinary](50) NOT NULL,
	[view_state] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[params] [varbinary](100) NOT NULL,
	[view_date] [bigint] NOT NULL,
	[robot_key] [varbinary](25) NOT NULL,
	[unique_key] [varbinary](16) NOT NULL,
	[ip] [varbinary](16) NOT NULL,
 CONSTRAINT [PK_xf_session_activity_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[unique_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [view_date]    Script Date: 5/15/2018 12:00:33 PM ******/
CREATE NONCLUSTERED INDEX [view_date] ON [dbo].[xf_session_activity]
(
	[view_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_session_activity] ADD  DEFAULT (0x) FOR [robot_key]
ALTER TABLE [dbo].[xf_session_activity] ADD  DEFAULT (0x) FOR [ip]
GO
