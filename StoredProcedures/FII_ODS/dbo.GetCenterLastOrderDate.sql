/****** Object:  StoredProcedure [dbo].[GetCenterLastOrderDate]    Script Date: 5/15/2018 12:09:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[GetCenterLastOrderDate]
	@ZW_FranciseID CHAR(7)
AS
BEGIN
 SELECT TOP 1 [OrderDate]
  FROM [Orders].[OrderHeaderFact]
  WHERE ZW_Franchise_ID=@ZW_FranciseID AND OrderDate IS NOT NULL
  ORDER BY OrderDate desc
END

GO
