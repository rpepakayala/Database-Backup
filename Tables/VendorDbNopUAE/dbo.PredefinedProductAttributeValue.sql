/****** Object:  Table [dbo].[PredefinedProductAttributeValue]    Script Date: 5/15/2018 12:08:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PredefinedProductAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductAttributeId] [int] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PriceAdjustment] [decimal](18, 4) NOT NULL,
	[WeightAdjustment] [decimal](18, 4) NOT NULL,
	[Cost] [decimal](18, 4) NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[PredefinedProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [PredefinedProductAttributeValue_ProductAttribute] FOREIGN KEY([ProductAttributeId])
REFERENCES [dbo].[ProductAttribute] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[PredefinedProductAttributeValue] CHECK CONSTRAINT [PredefinedProductAttributeValue_ProductAttribute]
GO
