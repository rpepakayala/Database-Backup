/****** Object:  Table [dbo].[xf_registration_spam_cache]    Script Date: 5/15/2018 12:00:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_registration_spam_cache](
	[cache_key] [varbinary](128) NOT NULL,
	[result] [varbinary](max) NOT NULL,
	[timeout] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_registration_spam_cache_cache_key] PRIMARY KEY CLUSTERED 
(
	[cache_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [timeout]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [timeout] ON [dbo].[xf_registration_spam_cache]
(
	[timeout] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_registration_spam_cache] ADD  DEFAULT (0x) FOR [cache_key]
ALTER TABLE [dbo].[xf_registration_spam_cache] ADD  DEFAULT ((0)) FOR [timeout]
GO
