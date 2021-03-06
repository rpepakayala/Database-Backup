/****** Object:  Table [dbo].[xf_flood_check]    Script Date: 5/15/2018 12:00:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_flood_check](
	[user_id] [bigint] NOT NULL,
	[flood_action] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[flood_time] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_flood_check_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[flood_action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [flood_time]    Script Date: 5/15/2018 12:00:21 PM ******/
CREATE NONCLUSTERED INDEX [flood_time] ON [dbo].[xf_flood_check]
(
	[flood_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
