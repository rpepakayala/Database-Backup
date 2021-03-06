/****** Object:  StoredProcedure [dbo].[GetOrderDetailsById]    Script Date: 5/15/2018 12:09:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE PROCEDURE [dbo].[GetOrderDetailsById]
                @ZW_FranciseID CHAR(7),
                @OrderId int
AS
BEGIN

SELECT ProductDecription
        ,Height
        ,Width
        ,SignText
        ,ItemTotal
        ,LineItemNumber
        ,OrderDetailID
        ,OrderID
        ,ProductCode
        ,ProductID
        ,Quantity
        ,ZW_Franchise_ID
  FROM dbo.vw_OrderDetails
  WHERE ZW_Franchise_ID=@ZW_FranciseID AND OrderID = @OrderId
END


GO
