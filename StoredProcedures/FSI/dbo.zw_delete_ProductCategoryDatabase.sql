/****** Object:  StoredProcedure [dbo].[zw_delete_ProductCategoryDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_ProductCategoryDatabase ( 
@ProductCategoryID int  = NULL , 
@StoreID int  = NULL , 
@ProductCategory varchar(35)   = NULL , 
@ActiveCategory bit  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Product Category Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ProductCategoryID] = @ProductCategoryID
		AND [StoreID] = @StoreID

GO
