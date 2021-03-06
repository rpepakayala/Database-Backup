/****** Object:  Table [dbo].[Segment]    Script Date: 5/15/2018 12:05:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Segment](
	[SegmentId] [uniqueidentifier] NOT NULL,
	[Content] [varbinary](max) NULL,
 CONSTRAINT [PK_Segment] PRIMARY KEY CLUSTERED 
(
	[SegmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_SegmentMetadata]    Script Date: 5/15/2018 12:05:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SegmentMetadata] ON [dbo].[Segment]
(
	[SegmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Segment] ADD  CONSTRAINT [DF_Segment_SegmentId]  DEFAULT (newsequentialid()) FOR [SegmentId]
GO
