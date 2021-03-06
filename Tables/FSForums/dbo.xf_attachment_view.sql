/****** Object:  Table [dbo].[xf_attachment_view]    Script Date: 5/15/2018 12:00:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_attachment_view](
	[attachment_id] [bigint] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [attachment_id]    Script Date: 5/15/2018 12:00:16 PM ******/
CREATE NONCLUSTERED INDEX [attachment_id] ON [dbo].[xf_attachment_view]
(
	[attachment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
