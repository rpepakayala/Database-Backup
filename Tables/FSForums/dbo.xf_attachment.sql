/****** Object:  Table [dbo].[xf_attachment]    Script Date: 5/15/2018 12:00:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_attachment](
	[attachment_id] [bigint] IDENTITY(5300,1) NOT NULL,
	[data_id] [bigint] NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[attach_date] [bigint] NOT NULL,
	[temp_hash] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[unassociated] [tinyint] NOT NULL,
	[view_count] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_attachment_attachment_id] PRIMARY KEY CLUSTERED 
(
	[attachment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [content_type_id_date]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [content_type_id_date] ON [dbo].[xf_attachment]
(
	[content_type] ASC,
	[content_id] ASC,
	[attach_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [temp_hash_attach_date]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [temp_hash_attach_date] ON [dbo].[xf_attachment]
(
	[temp_hash] ASC,
	[attach_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [unassociated_attach_date]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [unassociated_attach_date] ON [dbo].[xf_attachment]
(
	[unassociated] ASC,
	[attach_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_attachment] ADD  DEFAULT (N'') FOR [temp_hash]
ALTER TABLE [dbo].[xf_attachment] ADD  DEFAULT ((0)) FOR [view_count]
GO
