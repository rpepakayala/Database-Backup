/****** Object:  Table [dbo].[xf_thread_redirect]    Script Date: 5/15/2018 12:00:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_thread_redirect](
	[thread_id] [bigint] NOT NULL,
	[target_url] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[redirect_key] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[expiry_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_thread_redirect_thread_id] PRIMARY KEY CLUSTERED 
(
	[thread_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [redirect_key_expiry_date]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [redirect_key_expiry_date] ON [dbo].[xf_thread_redirect]
(
	[redirect_key] ASC,
	[expiry_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_thread_redirect] ADD  DEFAULT (N'') FOR [redirect_key]
ALTER TABLE [dbo].[xf_thread_redirect] ADD  DEFAULT ((0)) FOR [expiry_date]
GO
