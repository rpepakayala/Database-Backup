/****** Object:  Table [dbo].[phpkb_article_visits]    Script Date: 5/15/2018 11:59:15 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_article_visits](
	[visit_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[article_hits] [int] NOT NULL,
	[visit_date] [smalldatetime] NOT NULL,
 CONSTRAINT [visit_id] PRIMARY KEY CLUSTERED 
(
	[visit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_article_visits]  WITH CHECK ADD  CONSTRAINT [fk___article_visit] FOREIGN KEY([article_id])
REFERENCES [dbo].[phpkb_articles] ([article_id])
ALTER TABLE [dbo].[phpkb_article_visits] CHECK CONSTRAINT [fk___article_visit]
GO
