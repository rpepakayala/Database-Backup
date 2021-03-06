/****** Object:  Table [dbo].[employee_time]    Script Date: 5/15/2018 12:04:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[employee_time](
	[employee_time_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[calendar_dt] [date] NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[employee_data_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[shift_type] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[approved_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[approved_on] [datetime2](0) NULL,
	[shift_start] [time](7) NULL,
	[start_actual_time] [time](7) NULL,
	[shift_end] [time](7) NULL,
	[end_actual_time] [time](7) NULL,
	[shift_cumulative_time] [time](7) NULL,
	[adjusted_cumulative_time] [int] NULL,
	[start_ip_address] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[end_ip_address] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[submitted_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[notes] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_employee_time_employee_time_id] PRIMARY KEY CLUSTERED 
(
	[employee_time_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [approved_by]    Script Date: 5/15/2018 12:04:05 PM ******/
CREATE NONCLUSTERED INDEX [approved_by] ON [dbo].[employee_time]
(
	[approved_by] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [employee_data_id]    Script Date: 5/15/2018 12:04:05 PM ******/
CREATE NONCLUSTERED INDEX [employee_data_id] ON [dbo].[employee_time]
(
	[employee_data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:05 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[employee_time]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [employee_data_id]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [approved_by]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [approved_on]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [shift_start]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [start_actual_time]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [shift_end]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [end_actual_time]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [shift_cumulative_time]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [adjusted_cumulative_time]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [start_ip_address]
ALTER TABLE [dbo].[employee_time] ADD  DEFAULT (NULL) FOR [end_ip_address]
GO
