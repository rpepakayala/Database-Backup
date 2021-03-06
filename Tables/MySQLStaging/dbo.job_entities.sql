/****** Object:  Table [dbo].[job_entities]    Script Date: 5/15/2018 12:04:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[job_entities](
	[job_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[account_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[role_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_on] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_job_entities_job_id] PRIMARY KEY CLUSTERED 
(
	[job_id] ASC,
	[entity_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [account_id]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [account_id] ON [dbo].[job_entities]
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_job_entities_entity_id_role_id_includes]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [idx_job_entities_entity_id_role_id_includes] ON [dbo].[job_entities]
(
	[entity_id] ASC,
	[role_id] ASC
)
INCLUDE ( 	[job_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_job_entities_role_id_includes]    Script Date: 5/15/2018 12:04:14 PM ******/
CREATE NONCLUSTERED INDEX [idx_job_entities_role_id_includes] ON [dbo].[job_entities]
(
	[role_id] ASC
)
INCLUDE ( 	[job_id],
	[entity_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
ALTER TABLE [dbo].[job_entities] ADD  DEFAULT (NULL) FOR [account_id]
ALTER TABLE [dbo].[job_entities] ADD  DEFAULT (N'') FOR [role_id]
GO
