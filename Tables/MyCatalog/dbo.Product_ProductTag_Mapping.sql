/****** Object:  Table [dbo].[Product_ProductTag_Mapping]    Script Date: 5/15/2018 12:03:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Product_ProductTag_Mapping](
	[ProductTag_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductTag_Id] ASC,
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [HINT_ix_Product_ProductTag_Mapping_Product_Id]    Script Date: 5/15/2018 12:03:30 PM ******/
CREATE NONCLUSTERED INDEX [HINT_ix_Product_ProductTag_Mapping_Product_Id] ON [dbo].[Product_ProductTag_Mapping]
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
ALTER TABLE [dbo].[Product_ProductTag_Mapping]  WITH CHECK ADD  CONSTRAINT [ProductTag_Products_Source] FOREIGN KEY([ProductTag_Id])
REFERENCES [dbo].[ProductTag] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Product_ProductTag_Mapping] CHECK CONSTRAINT [ProductTag_Products_Source]
ALTER TABLE [dbo].[Product_ProductTag_Mapping]  WITH CHECK ADD  CONSTRAINT [ProductTag_Products_Target] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Product_ProductTag_Mapping] CHECK CONSTRAINT [ProductTag_Products_Target]
GO
