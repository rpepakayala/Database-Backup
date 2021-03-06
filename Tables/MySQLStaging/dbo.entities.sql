/****** Object:  Table [dbo].[entities]    Script Date: 5/15/2018 12:04:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[entities](
	[entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[entity_type_id] [int] NOT NULL,
	[user_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_created] [datetime2](0) NULL,
	[created_by] [int] NULL,
	[last_modified] [datetime] NOT NULL,
	[modified_by] [int] NULL,
 CONSTRAINT [PK_entities_entity_id] PRIMARY KEY CLUSTERED 
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [entity_type_id]    Script Date: 5/15/2018 12:04:05 PM ******/
CREATE NONCLUSTERED INDEX [entity_type_id] ON [dbo].[entities]
(
	[entity_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:05 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[entities]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:04:05 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[entities]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[entities] ADD  DEFAULT ((1)) FOR [entity_type_id]
ALTER TABLE [dbo].[entities] ADD  DEFAULT (NULL) FOR [user_id]
ALTER TABLE [dbo].[entities] ADD  DEFAULT (NULL) FOR [parent_id]
ALTER TABLE [dbo].[entities] ADD  DEFAULT (NULL) FOR [created_by]
ALTER TABLE [dbo].[entities] ADD  DEFAULT (getdate()) FOR [last_modified]
ALTER TABLE [dbo].[entities] ADD  DEFAULT (NULL) FOR [modified_by]
GO
