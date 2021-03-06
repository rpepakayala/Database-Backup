/****** Object:  Table [dbo].[appointments]    Script Date: 5/15/2018 12:03:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[appointments](
	[appointment_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[appointment_type_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[address_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[job_line_item_service_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[assigned_entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[title] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[start_datetime] [datetime2](0) NOT NULL,
	[end_datetime] [datetime2](0) NOT NULL,
	[all_day] [smallint] NOT NULL,
	[vehicle_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[notes] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[last_modified_on] [datetime] NOT NULL,
	[cancelled] [smallint] NOT NULL,
	[cancelled_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cancelled_on] [datetime2](0) NULL,
	[parked] [smallint] NULL,
	[parked_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_appointments_appointment_id] PRIMARY KEY CLUSTERED 
(
	[appointment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [address_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [address_id] ON [dbo].[appointments]
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [appointment_type_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [appointment_type_id] ON [dbo].[appointments]
(
	[appointment_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [assigned_entity_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [assigned_entity_id] ON [dbo].[appointments]
(
	[assigned_entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [cancelled_by]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [cancelled_by] ON [dbo].[appointments]
(
	[cancelled_by] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [created_by]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [created_by] ON [dbo].[appointments]
(
	[created_by] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [entity_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [entity_id] ON [dbo].[appointments]
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[appointments]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [job_line_item_service_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [job_line_item_service_id] ON [dbo].[appointments]
(
	[job_line_item_service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [start_datetime]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [start_datetime] ON [dbo].[appointments]
(
	[start_datetime] ASC,
	[end_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [vehicle_id]    Script Date: 5/15/2018 12:03:58 PM ******/
CREATE NONCLUSTERED INDEX [vehicle_id] ON [dbo].[appointments]
(
	[vehicle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [entity_id]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [address_id]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [job_line_item_service_id]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [title]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (getdate()) FOR [start_datetime]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (getdate()) FOR [end_datetime]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT ((0)) FOR [all_day]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [vehicle_id]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (getdate()) FOR [created_on]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (getdate()) FOR [last_modified_on]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT ((0)) FOR [cancelled]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [cancelled_by]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [cancelled_on]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT ((0)) FOR [parked]
ALTER TABLE [dbo].[appointments] ADD  DEFAULT (NULL) FOR [parked_by]
GO
