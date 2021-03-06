/****** Object:  Table [dbo].[popups]    Script Date: 5/15/2018 12:04:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[popups](
	[popup_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entity_type] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[employee_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[expires] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[expires_on] [datetime2](0) NULL,
	[active] [smallint] NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime2](0) NULL,
	[modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[modified_on] [datetime2](0) NULL,
 CONSTRAINT [PK_popups_popup_id] PRIMARY KEY CLUSTERED 
(
	[popup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [active]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [active] ON [dbo].[popups]
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [employee_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [employee_id] ON [dbo].[popups]
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [entity_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [entity_id] ON [dbo].[popups]
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:23 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[popups]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (N'') FOR [popup_id]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [franchise_id]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [entity_id]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (N'entity') FOR [entity_type]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [employee_id]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (N'Never') FOR [expires]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [expires_on]
ALTER TABLE [dbo].[popups] ADD  DEFAULT ((1)) FOR [active]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [created_by]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [modified_by]
ALTER TABLE [dbo].[popups] ADD  DEFAULT (NULL) FOR [modified_on]
GO
