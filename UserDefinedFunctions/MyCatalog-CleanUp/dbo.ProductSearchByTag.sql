/****** Object:  UserDefinedFunction [dbo].[ProductSearchByTag]    Script Date: 5/15/2018 12:14:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION [dbo].[ProductSearchByTag] 
(	
	@StoreId int, 
	@Keywords nvarchar(4000)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT p.Id AS Id, RANK AS SearchRank 
	FROM [Product] As p
		INNER JOIN Product_ProductTag_Mapping AS pMap ON p.Id = pMap.Product_Id AND p.StoreId = @StoreId
		INNER JOIN FREETEXTTABLE(ProductTag,*,@Keywords) AS tagTxt ON pMap.ProductTag_Id = tagTxt.[KEY]
)

GO
