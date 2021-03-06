/****** Object:  Table [dbo].[franchise_tax]    Script Date: 5/15/2018 12:04:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[franchise_tax](
	[franchise_tax_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_name] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active_flag] [smallint] NULL,
	[tax_description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_rate] [decimal](12, 5) NULL,
	[created_on] [datetime2](0) NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_service_flag] [smallint] NULL,
 CONSTRAINT [PK_franchise_tax_franchise_tax_id] PRIMARY KEY CLUSTERED 
(
	[franchise_tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:10 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[franchise_tax]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [franchise_id]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [tax_name]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [active_flag]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [tax_description]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [tax_rate]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [created_by]
ALTER TABLE [dbo].[franchise_tax] ADD  DEFAULT (NULL) FOR [tax_service_flag]
GO
