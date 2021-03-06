/****** Object:  Table [dbo].[phpkb_relations]    Script Date: 5/15/2018 11:59:18 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_relations](
	[relation_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
 CONSTRAINT [relation_id] PRIMARY KEY CLUSTERED 
(
	[relation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_relations]  WITH CHECK ADD  CONSTRAINT [fk___article_relation] FOREIGN KEY([article_id])
REFERENCES [dbo].[phpkb_articles] ([article_id])
ALTER TABLE [dbo].[phpkb_relations] CHECK CONSTRAINT [fk___article_relation]
ALTER TABLE [dbo].[phpkb_relations]  WITH CHECK ADD  CONSTRAINT [fk___category_relation] FOREIGN KEY([category_id])
REFERENCES [dbo].[phpkb_categories] ([category_id])
ALTER TABLE [dbo].[phpkb_relations] CHECK CONSTRAINT [fk___category_relation]
GO
