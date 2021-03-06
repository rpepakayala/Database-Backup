/****** Object:  View [dbo].[vAmazonProductInsert]    Script Date: 5/15/2018 12:14:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW dbo.vAmazonProductInsert
AS
SELECT dbo.Product.*, dbo.Product_Picture_Mapping.PictureId, dbo.Picture.PictureBinary, dbo.Picture.MimeType, dbo.Picture.IsNew
FROM   dbo.Product INNER JOIN
             dbo.Product_Picture_Mapping ON dbo.Product.Id = dbo.Product_Picture_Mapping.ProductId INNER JOIN
             dbo.Picture ON dbo.Product_Picture_Mapping.PictureId = dbo.Picture.Id

GO
