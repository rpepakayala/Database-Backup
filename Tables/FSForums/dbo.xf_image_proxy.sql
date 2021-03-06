/****** Object:  Table [dbo].[xf_image_proxy]    Script Date: 5/15/2018 12:00:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_image_proxy](
	[image_id] [bigint] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[url_hash] [varbinary](32) NOT NULL,
	[file_size] [bigint] NOT NULL,
	[file_name] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[mime_type] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[fetch_date] [bigint] NOT NULL,
	[first_request_date] [bigint] NOT NULL,
	[last_request_date] [bigint] NOT NULL,
	[views] [bigint] NOT NULL,
	[pruned] [bigint] NOT NULL,
	[is_processing] [bigint] NOT NULL,
	[failed_date] [bigint] NOT NULL,
	[fail_count] [int] NOT NULL,
 CONSTRAINT [PK_xf_image_proxy_image_id] PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_image_proxy$url_hash] UNIQUE NONCLUSTERED 
(
	[url_hash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [last_request_date]    Script Date: 5/15/2018 12:00:23 PM ******/
CREATE NONCLUSTERED INDEX [last_request_date] ON [dbo].[xf_image_proxy]
(
	[last_request_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [pruned_fetch_date]    Script Date: 5/15/2018 12:00:23 PM ******/
CREATE NONCLUSTERED INDEX [pruned_fetch_date] ON [dbo].[xf_image_proxy]
(
	[pruned] ASC,
	[fetch_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [file_size]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT (N'') FOR [file_name]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT (N'') FOR [mime_type]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [fetch_date]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [first_request_date]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [last_request_date]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [views]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [pruned]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [is_processing]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [failed_date]
ALTER TABLE [dbo].[xf_image_proxy] ADD  DEFAULT ((0)) FOR [fail_count]
GO
