/****** Object:  Table [dbo].[Product_Picture_Mapping]    Script Date: 5/15/2018 12:04:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Product_Picture_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Product_Picture_Mapping]  WITH CHECK ADD  CONSTRAINT [ProductPicture_Picture] FOREIGN KEY([PictureId])
REFERENCES [dbo].[Picture] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Product_Picture_Mapping] CHECK CONSTRAINT [ProductPicture_Picture]
ALTER TABLE [dbo].[Product_Picture_Mapping]  WITH CHECK ADD  CONSTRAINT [ProductPicture_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Product_Picture_Mapping] CHECK CONSTRAINT [ProductPicture_Product]
GO
