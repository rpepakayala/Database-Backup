/****** Object:  Table [dbo].[sysalerts]    Script Date: 5/15/2018 12:03:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysalerts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[event_source] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[event_category_id] [int] NULL,
	[event_id] [int] NULL,
	[message_id] [int] NOT NULL,
	[severity] [int] NOT NULL,
	[enabled] [tinyint] NOT NULL,
	[delay_between_responses] [int] NOT NULL,
	[last_occurrence_date] [int] NOT NULL,
	[last_occurrence_time] [int] NOT NULL,
	[last_response_date] [int] NOT NULL,
	[last_response_time] [int] NOT NULL,
	[notification_message] [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[include_event_description] [tinyint] NOT NULL,
	[database_name] [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[event_description_keyword] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[occurrence_count] [int] NOT NULL,
	[count_reset_date] [int] NOT NULL,
	[count_reset_time] [int] NOT NULL,
	[job_id] [uniqueidentifier] NOT NULL,
	[has_notification] [int] NOT NULL,
	[flags] [int] NOT NULL,
	[performance_condition] [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[category_id] [int] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [ByName]    Script Date: 5/15/2018 12:03:00 PM ******/
CREATE UNIQUE CLUSTERED INDEX [ByName] ON [dbo].[sysalerts]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [ByID]    Script Date: 5/15/2018 12:03:00 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ByID] ON [dbo].[sysalerts]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
