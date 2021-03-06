/****** Object:  Table [dbo].[xf_bb_code_parse_cache]    Script Date: 5/15/2018 12:00:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_bb_code_parse_cache](
	[bb_code_parse_cache_id] [bigint] IDENTITY(1,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[parse_tree] [varbinary](max) NOT NULL,
	[cache_version] [bigint] NOT NULL,
	[cache_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_bb_code_parse_cache_bb_code_parse_cache_id] PRIMARY KEY CLUSTERED 
(
	[bb_code_parse_cache_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_bb_code_parse_cache$content_type_id] UNIQUE NONCLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [cache_date]    Script Date: 5/15/2018 12:00:17 PM ******/
CREATE NONCLUSTERED INDEX [cache_date] ON [dbo].[xf_bb_code_parse_cache]
(
	[cache_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [cache_version]    Script Date: 5/15/2018 12:00:17 PM ******/
CREATE NONCLUSTERED INDEX [cache_version] ON [dbo].[xf_bb_code_parse_cache]
(
	[cache_version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_bb_code_parse_cache] ADD  DEFAULT ((0)) FOR [cache_date]
GO
