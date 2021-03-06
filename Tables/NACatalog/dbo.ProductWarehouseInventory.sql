/****** Object:  Table [dbo].[ProductWarehouseInventory]    Script Date: 5/15/2018 12:04:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductWarehouseInventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[ReservedQuantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ProductWarehouseInventory]  WITH CHECK ADD  CONSTRAINT [ProductWarehouseInventory_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductWarehouseInventory] CHECK CONSTRAINT [ProductWarehouseInventory_Product]
ALTER TABLE [dbo].[ProductWarehouseInventory]  WITH CHECK ADD  CONSTRAINT [ProductWarehouseInventory_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductWarehouseInventory] CHECK CONSTRAINT [ProductWarehouseInventory_Warehouse]
GO
