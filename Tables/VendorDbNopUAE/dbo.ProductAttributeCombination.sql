/****** Object:  Table [dbo].[ProductAttributeCombination]    Script Date: 5/15/2018 12:08:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductAttributeCombination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[AttributesXml] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StockQuantity] [int] NOT NULL,
	[AllowOutOfStockOrders] [bit] NOT NULL,
	[Sku] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManufacturerPartNumber] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Gtin] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OverriddenPrice] [decimal](18, 4) NULL,
	[NotifyAdminForQuantityBelow] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[ProductAttributeCombination]  WITH CHECK ADD  CONSTRAINT [ProductAttributeCombination_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductAttributeCombination] CHECK CONSTRAINT [ProductAttributeCombination_Product]
GO
