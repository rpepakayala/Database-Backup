/****** Object:  StoredProcedure [dbo].[ShoppingCartVendorView]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE  PROCEDURE dbo.ShoppingCartVendorView 
(
	@StoreId int
)
AS
SELECT Distinct V.VndId FROM ShoppingCart SC
Inner Join Material M On Sc.ScPrdId=M.MatID
Inner Join Vendor V On M.MatVendorId = V.VndId
Where SC.ScOrderPrdType=1 and SC.ScType=1 AND SC.ScStoreId = @StoreId
Order By V.VndId


GO
