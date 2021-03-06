/****** Object:  Table [dbo].[sf_cs_threads]    Script Date: 5/15/2018 12:01:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_cs_threads](
	[type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[resolve_key] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[require_authentication] [tinyint] NOT NULL,
	[require_approval] [tinyint] NOT NULL,
	[parent_group_id] [uniqueidentifier] NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[language] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_closed] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[date_created] [datetime] NULL,
	[data_source] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[comments_count] [int] NOT NULL,
	[behavior] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[average_rating] [numeric](20, 10) NULL,
	[author_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[author_id] [uniqueidentifier] NULL,
	[author_email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_cs_threads] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_cs_threads_group]    Script Date: 5/15/2018 12:01:28 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_cs_threads_group] ON [dbo].[sf_cs_threads]
(
	[parent_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_cs_threads_key]    Script Date: 5/15/2018 12:01:28 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_sf_cs_threads_key] ON [dbo].[sf_cs_threads]
(
	[resolve_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
