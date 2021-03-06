/****** Object:  Table [dbo].[ProductVariant_ProductAttribute_Mapping]    Script Date: 5/15/2018 12:03:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductVariant_ProductAttribute_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductVariantId] [int] NOT NULL,
	[ProductAttributeId] [int] NOT NULL,
	[TextPrompt] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsRequired] [bit] NOT NULL,
	[AttributeControlTypeId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_ProductVariant_ProductAttribute_Mapping_ProductVariantId]    Script Date: 5/15/2018 12:03:31 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductVariant_ProductAttribute_Mapping_ProductVariantId] ON [dbo].[ProductVariant_ProductAttribute_Mapping]
(
	[ProductVariantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[ProductVariant_ProductAttribute_Mapping]  WITH CHECK ADD  CONSTRAINT [ProductVariantAttribute_ProductAttribute] FOREIGN KEY([ProductAttributeId])
REFERENCES [dbo].[ProductAttribute] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductVariant_ProductAttribute_Mapping] CHECK CONSTRAINT [ProductVariantAttribute_ProductAttribute]
ALTER TABLE [dbo].[ProductVariant_ProductAttribute_Mapping]  WITH CHECK ADD  CONSTRAINT [ProductVariantAttribute_ProductVariant] FOREIGN KEY([ProductVariantId])
REFERENCES [dbo].[ProductVariant] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductVariant_ProductAttribute_Mapping] CHECK CONSTRAINT [ProductVariantAttribute_ProductVariant]
GO
