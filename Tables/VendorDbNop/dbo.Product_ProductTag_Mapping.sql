/****** Object:  Table [dbo].[Product_ProductTag_Mapping]    Script Date: 5/15/2018 12:07:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Product_ProductTag_Mapping](
	[Product_Id] [int] NOT NULL,
	[ProductTag_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Product_Id] ASC,
	[ProductTag_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Product_ProductTag_Mapping]  WITH CHECK ADD  CONSTRAINT [Product_ProductTags_Source] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Product_ProductTag_Mapping] CHECK CONSTRAINT [Product_ProductTags_Source]
ALTER TABLE [dbo].[Product_ProductTag_Mapping]  WITH CHECK ADD  CONSTRAINT [Product_ProductTags_Target] FOREIGN KEY([ProductTag_Id])
REFERENCES [dbo].[ProductTag] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Product_ProductTag_Mapping] CHECK CONSTRAINT [Product_ProductTags_Target]
GO
