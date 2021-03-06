/****** Object:  Table [dbo].[xf_template_history]    Script Date: 5/15/2018 12:00:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_template_history](
	[template_history_id] [bigint] IDENTITY(259,1) NOT NULL,
	[title] [varbinary](50) NOT NULL,
	[style_id] [bigint] NOT NULL,
	[template] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[edit_date] [bigint] NOT NULL,
	[log_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_template_history_template_history_id] PRIMARY KEY CLUSTERED 
(
	[template_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [log_date]    Script Date: 5/15/2018 12:00:35 PM ******/
CREATE NONCLUSTERED INDEX [log_date] ON [dbo].[xf_template_history]
(
	[log_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [style_id_title]    Script Date: 5/15/2018 12:00:35 PM ******/
CREATE NONCLUSTERED INDEX [style_id_title] ON [dbo].[xf_template_history]
(
	[style_id] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [title]    Script Date: 5/15/2018 12:00:35 PM ******/
CREATE NONCLUSTERED INDEX [title] ON [dbo].[xf_template_history]
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
