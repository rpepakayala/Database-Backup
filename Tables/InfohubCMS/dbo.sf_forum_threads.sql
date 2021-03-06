/****** Object:  Table [dbo].[sf_forum_threads]    Script Date: 5/15/2018 12:01:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_forum_threads](
	[views_count] [int] NOT NULL,
	[url_name_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[threadType] [int] NOT NULL,
	[subscr_lst_id] [uniqueidentifier] NULL,
	[posts_count] [int] NOT NULL,
	[ownr] [uniqueidentifier] NULL,
	[last_post_user_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_post_user_id] [uniqueidentifier] NULL,
	[last_post_id] [uniqueidentifier] NULL,
	[last_post_date] [datetime] NULL,
	[last_modified] [datetime] NOT NULL,
	[item_default_url_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_published] [tinyint] NOT NULL,
	[is_marked_spam] [tinyint] NOT NULL,
	[is_locked] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[forum_id] [uniqueidentifier] NOT NULL,
	[first_post_id] [uniqueidentifier] NULL,
	[date_created] [datetime] NOT NULL,
	[block_crawlers] [tinyint] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_forum_threads] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_forum_threads]    Script Date: 5/15/2018 12:01:41 PM ******/
CREATE NONCLUSTERED INDEX [idx_forum_threads] ON [dbo].[sf_forum_threads]
(
	[forum_id] ASC,
	[last_post_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
