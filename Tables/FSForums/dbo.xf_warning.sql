/****** Object:  Table [dbo].[xf_warning]    Script Date: 5/15/2018 12:00:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_warning](
	[warning_id] [bigint] IDENTITY(4,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[content_title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[user_id] [bigint] NOT NULL,
	[warning_date] [bigint] NOT NULL,
	[warning_user_id] [bigint] NOT NULL,
	[warning_definition_id] [bigint] NOT NULL,
	[title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[notes] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[points] [int] NOT NULL,
	[expiry_date] [bigint] NOT NULL,
	[is_expired] [tinyint] NOT NULL,
	[extra_user_group_ids] [varbinary](255) NOT NULL,
 CONSTRAINT [PK_xf_warning_warning_id] PRIMARY KEY CLUSTERED 
(
	[warning_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [content_type_id]    Script Date: 5/15/2018 12:00:42 PM ******/
CREATE NONCLUSTERED INDEX [content_type_id] ON [dbo].[xf_warning]
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [expiry]    Script Date: 5/15/2018 12:00:42 PM ******/
CREATE NONCLUSTERED INDEX [expiry] ON [dbo].[xf_warning]
(
	[expiry_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [user_id_date]    Script Date: 5/15/2018 12:00:42 PM ******/
CREATE NONCLUSTERED INDEX [user_id_date] ON [dbo].[xf_warning]
(
	[user_id] ASC,
	[warning_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
