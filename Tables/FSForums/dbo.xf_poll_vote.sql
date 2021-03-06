/****** Object:  Table [dbo].[xf_poll_vote]    Script Date: 5/15/2018 12:00:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_poll_vote](
	[user_id] [bigint] NOT NULL,
	[poll_response_id] [bigint] NOT NULL,
	[poll_id] [bigint] NOT NULL,
	[vote_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_poll_vote_poll_response_id] PRIMARY KEY CLUSTERED 
(
	[poll_response_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [poll_id_user_id]    Script Date: 5/15/2018 12:00:30 PM ******/
CREATE NONCLUSTERED INDEX [poll_id_user_id] ON [dbo].[xf_poll_vote]
(
	[poll_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:30 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_poll_vote]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_poll_vote] ADD  DEFAULT ((0)) FOR [vote_date]
GO
