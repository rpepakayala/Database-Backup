/****** Object:  Table [dbo].[xf_phrase_map]    Script Date: 5/15/2018 12:00:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_phrase_map](
	[phrase_map_id] [bigint] IDENTITY(11088,1) NOT NULL,
	[language_id] [bigint] NOT NULL,
	[title] [varbinary](100) NOT NULL,
	[phrase_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_phrase_map_phrase_map_id] PRIMARY KEY CLUSTERED 
(
	[phrase_map_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_phrase_map$language_id_title] UNIQUE NONCLUSTERED 
(
	[language_id] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [phrase_id]    Script Date: 5/15/2018 12:00:30 PM ******/
CREATE NONCLUSTERED INDEX [phrase_id] ON [dbo].[xf_phrase_map]
(
	[phrase_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
