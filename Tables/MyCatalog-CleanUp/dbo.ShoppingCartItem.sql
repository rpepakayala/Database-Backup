/****** Object:  Table [dbo].[ShoppingCartItem]    Script Date: 5/15/2018 12:03:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ShoppingCartItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingCartTypeId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductVariantId] [int] NOT NULL,
	[AttributesXml] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[Quantity] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_ShoppingCartItem_ShoppingCartTypeId_CustomerId]    Script Date: 5/15/2018 12:03:52 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartItem_ShoppingCartTypeId_CustomerId] ON [dbo].[ShoppingCartItem]
(
	[ShoppingCartTypeId] ASC,
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[ShoppingCartItem]  WITH CHECK ADD  CONSTRAINT [ShoppingCartItem_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ShoppingCartItem] CHECK CONSTRAINT [ShoppingCartItem_Customer]
ALTER TABLE [dbo].[ShoppingCartItem]  WITH CHECK ADD  CONSTRAINT [ShoppingCartItem_ProductVariant] FOREIGN KEY([ProductVariantId])
REFERENCES [dbo].[ProductVariant] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ShoppingCartItem] CHECK CONSTRAINT [ShoppingCartItem_ProductVariant]
GO
