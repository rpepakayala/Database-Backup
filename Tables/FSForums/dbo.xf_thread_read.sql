/****** Object:  Table [dbo].[xf_thread_read]    Script Date: 5/15/2018 12:00:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_thread_read](
	[thread_read_id] [bigint] IDENTITY(267727,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[thread_id] [bigint] NOT NULL,
	[thread_read_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_thread_read_thread_read_id] PRIMARY KEY CLUSTERED 
(
	[thread_read_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_thread_read$user_id_thread_id] UNIQUE NONCLUSTERED 
(
	[user_id] ASC,
	[thread_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [thread_id]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [thread_id] ON [dbo].[xf_thread_read]
(
	[thread_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [thread_read_date]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [thread_read_date] ON [dbo].[xf_thread_read]
(
	[thread_read_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
