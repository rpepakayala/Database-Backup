/****** Object:  Table [dbo].[xf_template_modification_log]    Script Date: 5/15/2018 12:00:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_template_modification_log](
	[template_id] [bigint] NOT NULL,
	[modification_id] [bigint] NOT NULL,
	[status] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[apply_count] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_template_modification_log_template_id] PRIMARY KEY CLUSTERED 
(
	[template_id] ASC,
	[modification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [modification_id]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [modification_id] ON [dbo].[xf_template_modification_log]
(
	[modification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_template_modification_log] ADD  DEFAULT ((0)) FOR [apply_count]
GO
