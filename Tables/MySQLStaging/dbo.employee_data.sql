/****** Object:  Table [dbo].[employee_data]    Script Date: 5/15/2018 12:04:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[employee_data](
	[employee_data_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[users_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[menu_group_items_id] [int] NOT NULL,
	[on_schedule] [smallint] NULL,
	[schedule_color] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[start_date] [date] NULL,
	[terminated_bool] [smallint] NULL,
	[termination_date] [date] NULL,
	[last_modified_on] [datetime2](0) NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_employee_data_employee_data_id] PRIMARY KEY CLUSTERED 
(
	[employee_data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [employee_data$employee_data_id] UNIQUE NONCLUSTERED 
(
	[employee_data_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [users_id]    Script Date: 5/15/2018 12:04:04 PM ******/
CREATE NONCLUSTERED INDEX [users_id] ON [dbo].[employee_data]
(
	[users_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT ((4)) FOR [menu_group_items_id]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [on_schedule]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [schedule_color]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [start_date]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [terminated_bool]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [termination_date]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [last_modified_on]
ALTER TABLE [dbo].[employee_data] ADD  DEFAULT (NULL) FOR [last_modified_by]
GO
