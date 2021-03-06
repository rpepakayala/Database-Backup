/****** Object:  Table [dbo].[TaxCategoryAttribute]    Script Date: 5/15/2018 12:03:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TaxCategoryAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaxCategoryId] [int] NOT NULL,
	[Key] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Value] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[TaxCategoryAttribute]  WITH CHECK ADD  CONSTRAINT [TaxCategoryAttribute_TaxCategory] FOREIGN KEY([TaxCategoryId])
REFERENCES [dbo].[TaxCategory] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[TaxCategoryAttribute] CHECK CONSTRAINT [TaxCategoryAttribute_TaxCategory]
GO
