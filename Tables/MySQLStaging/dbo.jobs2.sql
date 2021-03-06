/****** Object:  Table [dbo].[jobs2]    Script Date: 5/15/2018 12:04:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[jobs2](
	[job_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sequence] [int] NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[accounts_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[po_number] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[expires_on] [date] NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified_on] [datetime2](0) NULL,
	[ecommerce] [smallint] NULL,
	[royalty_exempt] [smallint] NOT NULL,
	[historical] [smallint] NOT NULL,
	[tracking_number] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[default_delivery_type] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[repeat_job_flag] [smallint] NOT NULL,
	[completed_date] [datetime2](0) NULL,
	[credit_balance] [decimal](11, 2) NOT NULL,
	[default_tax_service] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_jobs_job_id] PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [default_tax_service]    Script Date: 5/15/2018 12:04:16 PM ******/
CREATE NONCLUSTERED INDEX [default_tax_service] ON [dbo].[jobs2]
(
	[default_tax_service] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:16 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[jobs2]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [parent_id]    Script Date: 5/15/2018 12:04:16 PM ******/
CREATE NONCLUSTERED INDEX [parent_id] ON [dbo].[jobs2]
(
	[parent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [parent_id]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [accounts_id]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [po_number]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [expires_on]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [last_modified_by]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [last_modified_on]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT ((0)) FOR [ecommerce]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT ((0)) FOR [royalty_exempt]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT ((0)) FOR [historical]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [default_delivery_type]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [completed_date]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT ((0.00)) FOR [credit_balance]
ALTER TABLE [dbo].[jobs2] ADD  DEFAULT (NULL) FOR [default_tax_service]
GO
