/****** Object:  Table [dbo].[xf_user_upgrade_expired]    Script Date: 5/15/2018 12:00:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_upgrade_expired](
	[user_upgrade_record_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[user_upgrade_id] [bigint] NOT NULL,
	[start_date] [bigint] NOT NULL,
	[end_date] [bigint] NOT NULL,
	[extra] [varbinary](max) NOT NULL,
	[original_end_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_user_upgrade_expired_user_upgrade_record_id] PRIMARY KEY CLUSTERED 
(
	[user_upgrade_record_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [end_date]    Script Date: 5/15/2018 12:00:42 PM ******/
CREATE NONCLUSTERED INDEX [end_date] ON [dbo].[xf_user_upgrade_expired]
(
	[end_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_upgrade_expired] ADD  DEFAULT ((0)) FOR [end_date]
ALTER TABLE [dbo].[xf_user_upgrade_expired] ADD  DEFAULT ((0)) FOR [original_end_date]
GO
