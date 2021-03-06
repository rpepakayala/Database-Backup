/****** Object:  Table [dbo].[xf_link_proxy]    Script Date: 5/15/2018 12:00:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_link_proxy](
	[link_id] [bigint] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[url_hash] [varbinary](32) NOT NULL,
	[first_request_date] [bigint] NOT NULL,
	[last_request_date] [bigint] NOT NULL,
	[hits] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_link_proxy_link_id] PRIMARY KEY CLUSTERED 
(
	[link_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_link_proxy$url_hash] UNIQUE NONCLUSTERED 
(
	[url_hash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [last_request_date]    Script Date: 5/15/2018 12:00:24 PM ******/
CREATE NONCLUSTERED INDEX [last_request_date] ON [dbo].[xf_link_proxy]
(
	[last_request_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_link_proxy] ADD  DEFAULT ((0)) FOR [first_request_date]
ALTER TABLE [dbo].[xf_link_proxy] ADD  DEFAULT ((0)) FOR [last_request_date]
ALTER TABLE [dbo].[xf_link_proxy] ADD  DEFAULT ((0)) FOR [hits]
GO
