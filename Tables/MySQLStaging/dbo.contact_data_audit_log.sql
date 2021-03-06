/****** Object:  Table [dbo].[contact_data_audit_log]    Script Date: 5/15/2018 12:04:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[contact_data_audit_log](
	[contact_data_audit_log_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[contact_data_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[users_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[do_not_survey] [smallint] NULL,
	[do_not_postal_mail] [smallint] NULL,
	[do_not_email] [smallint] NULL,
	[last_modified_on] [datetime2](0) NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_contact_data_audit_log_contact_data_audit_log_id] PRIMARY KEY CLUSTERED 
(
	[contact_data_audit_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [contact_data_audit_log$contact_data_audit_log_id] UNIQUE NONCLUSTERED 
(
	[contact_data_audit_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[contact_data_audit_log] ADD  DEFAULT (NULL) FOR [users_id]
ALTER TABLE [dbo].[contact_data_audit_log] ADD  DEFAULT (NULL) FOR [do_not_survey]
ALTER TABLE [dbo].[contact_data_audit_log] ADD  DEFAULT (NULL) FOR [do_not_postal_mail]
ALTER TABLE [dbo].[contact_data_audit_log] ADD  DEFAULT (NULL) FOR [do_not_email]
ALTER TABLE [dbo].[contact_data_audit_log] ADD  DEFAULT (NULL) FOR [last_modified_on]
ALTER TABLE [dbo].[contact_data_audit_log] ADD  DEFAULT (NULL) FOR [last_modified_by]
GO
