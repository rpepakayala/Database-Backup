/****** Object:  Table [dbo].[xf_spam_trigger_log]    Script Date: 5/15/2018 12:00:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_spam_trigger_log](
	[trigger_log_id] [bigint] IDENTITY(6,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NULL,
	[log_date] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[ip_address] [varbinary](16) NOT NULL,
	[result] [varbinary](25) NOT NULL,
	[details] [varbinary](max) NOT NULL,
	[request_state] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_spam_trigger_log_trigger_log_id] PRIMARY KEY CLUSTERED 
(
	[trigger_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_spam_trigger_log$content_type] UNIQUE NONCLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [log_date]    Script Date: 5/15/2018 12:00:34 PM ******/
CREATE NONCLUSTERED INDEX [log_date] ON [dbo].[xf_spam_trigger_log]
(
	[log_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_spam_trigger_log] ADD  DEFAULT (NULL) FOR [content_id]
GO
