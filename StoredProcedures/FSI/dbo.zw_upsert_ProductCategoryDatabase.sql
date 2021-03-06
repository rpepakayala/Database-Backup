/****** Object:  StoredProcedure [dbo].[zw_upsert_ProductCategoryDatabase]    Script Date: 5/15/2018 12:09:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_ProductCategoryDatabase ( 
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
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'Product Category Database'
 
	 UPDATE [Product Category Database] 
	 SET   
		[ProductCategory] = @ProductCategory, 
		[ActiveCategory] = @ActiveCategory, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ProductCategoryID] = @ProductCategoryID
		AND [StoreID] = @StoreID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Product Category Database]( [ProductCategoryID], [StoreID], [ProductCategory], [ActiveCategory], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ProductCategoryID, @StoreID, @ProductCategory, @ActiveCategory, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
