/****** Object:  Table [dbo].[dsol_template]    Script Date: 5/15/2018 12:04:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[dsol_template](
	[dsol_template_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[dsol_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[default_template_size] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[template_data] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime2](0) NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[modified_on] [datetime2](0) NULL,
	[modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_dsol_template_dsol_template_id] PRIMARY KEY CLUSTERED 
(
	[dsol_template_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [dsol_item_template_fkey]    Script Date: 5/15/2018 12:04:04 PM ******/
CREATE NONCLUSTERED INDEX [dsol_item_template_fkey] ON [dbo].[dsol_template]
(
	[dsol_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[dsol_template] ADD  DEFAULT (NULL) FOR [name]
ALTER TABLE [dbo].[dsol_template] ADD  DEFAULT (NULL) FOR [default_template_size]
ALTER TABLE [dbo].[dsol_template] ADD  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[dsol_template] ADD  DEFAULT (NULL) FOR [created_by]
ALTER TABLE [dbo].[dsol_template] ADD  DEFAULT (NULL) FOR [modified_on]
ALTER TABLE [dbo].[dsol_template] ADD  DEFAULT (NULL) FOR [modified_by]
GO
