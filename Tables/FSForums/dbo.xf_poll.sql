/****** Object:  Table [dbo].[xf_poll]    Script Date: 5/15/2018 12:00:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_poll](
	[poll_id] [bigint] IDENTITY(34,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[question] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[responses] [varbinary](max) NOT NULL,
	[voter_count] [bigint] NOT NULL,
	[public_votes] [tinyint] NOT NULL,
	[multiple] [tinyint] NOT NULL,
	[close_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_poll_poll_id] PRIMARY KEY CLUSTERED 
(
	[poll_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_poll$content_type_content_id] UNIQUE NONCLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_poll] ADD  DEFAULT ((0)) FOR [voter_count]
ALTER TABLE [dbo].[xf_poll] ADD  DEFAULT ((0)) FOR [public_votes]
ALTER TABLE [dbo].[xf_poll] ADD  DEFAULT ((0)) FOR [multiple]
ALTER TABLE [dbo].[xf_poll] ADD  DEFAULT ((0)) FOR [close_date]
GO
