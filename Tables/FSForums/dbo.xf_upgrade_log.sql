/****** Object:  Table [dbo].[xf_upgrade_log]    Script Date: 5/15/2018 12:00:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_upgrade_log](
	[version_id] [bigint] NOT NULL,
	[completion_date] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[log_type] [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_upgrade_log_version_id] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[xf_upgrade_log] ADD  DEFAULT ((0)) FOR [completion_date]
ALTER TABLE [dbo].[xf_upgrade_log] ADD  DEFAULT ((0)) FOR [user_id]
ALTER TABLE [dbo].[xf_upgrade_log] ADD  DEFAULT (N'upgrade') FOR [log_type]
GO
