/****** Object:  Table [dbo].[job_line_item_phase_history]    Script Date: 5/15/2018 12:04:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[job_line_item_phase_history](
	[job_line_item_phase_history_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[job_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[phase_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_phase_history] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[note] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[set_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[set_on] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_job_line_item_phase_history_job_line_item_phase_history_id] PRIMARY KEY CLUSTERED 
(
	[job_line_item_phase_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [job_line_item_id]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [job_line_item_id] ON [dbo].[job_line_item_phase_history]
(
	[job_line_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [phase_id]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [phase_id] ON [dbo].[job_line_item_phase_history]
(
	[phase_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[job_line_item_phase_history] ADD  DEFAULT (NULL) FOR [parent_phase_history]
GO
