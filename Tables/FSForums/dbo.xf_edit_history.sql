/****** Object:  Table [dbo].[xf_edit_history]    Script Date: 5/15/2018 12:00:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_edit_history](
	[edit_history_id] [bigint] IDENTITY(593,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[edit_user_id] [bigint] NOT NULL,
	[edit_date] [bigint] NOT NULL,
	[old_text] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_edit_history_edit_history_id] PRIMARY KEY CLUSTERED 
(
	[edit_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [content_type]    Script Date: 5/15/2018 12:00:20 PM ******/
CREATE NONCLUSTERED INDEX [content_type] ON [dbo].[xf_edit_history]
(
	[content_type] ASC,
	[content_id] ASC,
	[edit_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [edit_date]    Script Date: 5/15/2018 12:00:20 PM ******/
CREATE NONCLUSTERED INDEX [edit_date] ON [dbo].[xf_edit_history]
(
	[edit_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
