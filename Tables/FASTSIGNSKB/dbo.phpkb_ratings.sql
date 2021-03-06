/****** Object:  Table [dbo].[phpkb_ratings]    Script Date: 5/15/2018 11:59:18 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_ratings](
	[rating_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[article_rating] [int] NOT NULL,
	[machine_IP] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [rating_id] PRIMARY KEY CLUSTERED 
(
	[rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_ratings] ADD  DEFAULT ('0') FOR [article_rating]
ALTER TABLE [dbo].[phpkb_ratings]  WITH CHECK ADD  CONSTRAINT [fk___article_rating] FOREIGN KEY([article_id])
REFERENCES [dbo].[phpkb_articles] ([article_id])
ALTER TABLE [dbo].[phpkb_ratings] CHECK CONSTRAINT [fk___article_rating]
GO
