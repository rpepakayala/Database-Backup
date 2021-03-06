/****** Object:  Table [dbo].[phpkb_categories]    Script Date: 5/15/2018 11:59:16 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[category_description] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_id] [int] NOT NULL,
	[category_date] [smalldatetime] NOT NULL,
	[category_status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[category_hits] [int] NOT NULL,
	[category_show] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[category_priority] [int] NOT NULL,
	[category_icon] [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [category_id] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_categories] ADD  DEFAULT ('public') FOR [category_status]
ALTER TABLE [dbo].[phpkb_categories] ADD  DEFAULT ('0') FOR [category_hits]
ALTER TABLE [dbo].[phpkb_categories] ADD  DEFAULT ('yes') FOR [category_show]
ALTER TABLE [dbo].[phpkb_categories] ADD  DEFAULT (NULL) FOR [category_icon]
ALTER TABLE [dbo].[phpkb_categories]  WITH CHECK ADD CHECK  (([category_status]='private' OR [category_status]='public'))
ALTER TABLE [dbo].[phpkb_categories]  WITH CHECK ADD CHECK  (([category_show]='no' OR [category_show]='yes'))
GO
