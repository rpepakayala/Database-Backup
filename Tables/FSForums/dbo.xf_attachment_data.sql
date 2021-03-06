/****** Object:  Table [dbo].[xf_attachment_data]    Script Date: 5/15/2018 12:00:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_attachment_data](
	[data_id] [bigint] IDENTITY(5300,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[upload_date] [bigint] NOT NULL,
	[filename] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[file_size] [bigint] NOT NULL,
	[file_hash] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[width] [bigint] NOT NULL,
	[height] [bigint] NOT NULL,
	[thumbnail_width] [bigint] NOT NULL,
	[thumbnail_height] [bigint] NOT NULL,
	[attach_count] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_attachment_data_data_id] PRIMARY KEY CLUSTERED 
(
	[data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [attach_count]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [attach_count] ON [dbo].[xf_attachment_data]
(
	[attach_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [upload_date]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [upload_date] ON [dbo].[xf_attachment_data]
(
	[upload_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [user_id_upload_date]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [user_id_upload_date] ON [dbo].[xf_attachment_data]
(
	[user_id] ASC,
	[upload_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_attachment_data] ADD  DEFAULT ((0)) FOR [width]
ALTER TABLE [dbo].[xf_attachment_data] ADD  DEFAULT ((0)) FOR [height]
ALTER TABLE [dbo].[xf_attachment_data] ADD  DEFAULT ((0)) FOR [thumbnail_width]
ALTER TABLE [dbo].[xf_attachment_data] ADD  DEFAULT ((0)) FOR [thumbnail_height]
ALTER TABLE [dbo].[xf_attachment_data] ADD  DEFAULT ((0)) FOR [attach_count]
GO
