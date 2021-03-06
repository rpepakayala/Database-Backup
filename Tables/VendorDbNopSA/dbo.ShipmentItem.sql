/****** Object:  Table [dbo].[ShipmentItem]    Script Date: 5/15/2018 12:08:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ShipmentItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShipmentId] [int] NOT NULL,
	[OrderItemId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ShipmentItem]  WITH CHECK ADD  CONSTRAINT [ShipmentItem_Shipment] FOREIGN KEY([ShipmentId])
REFERENCES [dbo].[Shipment] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ShipmentItem] CHECK CONSTRAINT [ShipmentItem_Shipment]
GO
