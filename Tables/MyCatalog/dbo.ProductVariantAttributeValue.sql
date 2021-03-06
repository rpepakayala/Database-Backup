/****** Object:  Table [dbo].[ProductVariantAttributeValue]    Script Date: 5/15/2018 12:03:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductVariantAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductVariantAttributeId] [int] NOT NULL,
	[Name] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriceAdjustment] [decimal](18, 4) NOT NULL,
	[WeightAdjustment] [decimal](18, 4) NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_ProductVariantAttributeValue_ProductVariantAttributeId]    Script Date: 5/15/2018 12:03:32 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductVariantAttributeValue_ProductVariantAttributeId] ON [dbo].[ProductVariantAttributeValue]
(
	[ProductVariantAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[ProductVariantAttributeValue]  WITH CHECK ADD  CONSTRAINT [ProductVariantAttributeValue_ProductVariantAttribute] FOREIGN KEY([ProductVariantAttributeId])
REFERENCES [dbo].[ProductVariant_ProductAttribute_Mapping] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductVariantAttributeValue] CHECK CONSTRAINT [ProductVariantAttributeValue_ProductVariantAttribute]
GO
