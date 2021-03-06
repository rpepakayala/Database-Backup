/****** Object:  Table [dbo].[phpkb_article_collaboration]    Script Date: 5/15/2018 11:59:15 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_article_collaboration](
	[collaboration_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[collaborated_by] [int] NOT NULL,
	[collaboration] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[collaborated_on] [smalldatetime] NOT NULL,
 CONSTRAINT [collaboration_id] PRIMARY KEY CLUSTERED 
(
	[collaboration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_article_collaboration]  WITH CHECK ADD  CONSTRAINT [fk___article_collaboration] FOREIGN KEY([article_id])
REFERENCES [dbo].[phpkb_articles] ([article_id])
ALTER TABLE [dbo].[phpkb_article_collaboration] CHECK CONSTRAINT [fk___article_collaboration]
ALTER TABLE [dbo].[phpkb_article_collaboration]  WITH CHECK ADD  CONSTRAINT [fk___collboration_author] FOREIGN KEY([collaborated_by])
REFERENCES [dbo].[phpkb_authors] ([author_id])
ALTER TABLE [dbo].[phpkb_article_collaboration] CHECK CONSTRAINT [fk___collboration_author]
GO
