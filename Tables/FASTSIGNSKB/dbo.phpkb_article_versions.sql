/****** Object:  Table [dbo].[phpkb_article_versions]    Script Date: 5/15/2018 11:59:15 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_article_versions](
	[version_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[article_title] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[article_content] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[article_keywords] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[article_metadesc] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[version_saved_on] [smalldatetime] NOT NULL,
	[version_saved_by] [int] NOT NULL,
 CONSTRAINT [version_id] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_article_versions]  WITH CHECK ADD  CONSTRAINT [fk___article_version] FOREIGN KEY([article_id])
REFERENCES [dbo].[phpkb_articles] ([article_id])
ALTER TABLE [dbo].[phpkb_article_versions] CHECK CONSTRAINT [fk___article_version]
ALTER TABLE [dbo].[phpkb_article_versions]  WITH CHECK ADD  CONSTRAINT [fk___author_version] FOREIGN KEY([version_saved_by])
REFERENCES [dbo].[phpkb_authors] ([author_id])
ALTER TABLE [dbo].[phpkb_article_versions] CHECK CONSTRAINT [fk___author_version]
GO
