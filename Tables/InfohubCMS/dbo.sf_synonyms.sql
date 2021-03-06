/****** Object:  Table [dbo].[sf_synonyms]    Script Date: 5/15/2018 12:02:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_synonyms](
	[weight] [int] NOT NULL,
	[val] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[taxon_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[culture] [int] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_synonyms] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_synonyms_taxon_id]    Script Date: 5/15/2018 12:02:04 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_synonyms_taxon_id] ON [dbo].[sf_synonyms]
(
	[taxon_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
