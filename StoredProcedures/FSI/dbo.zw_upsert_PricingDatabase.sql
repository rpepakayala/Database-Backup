/****** Object:  StoredProcedure [dbo].[zw_upsert_PricingDatabase]    Script Date: 5/15/2018 12:09:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_PricingDatabase ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ProductID int  = NULL , 
@Height float  = NULL , 
@Width float  = NULL , 
@Depth float  = NULL , 
@Volume float  = NULL , 
@BasePrice float  = NULL , 
@BasePrice2S float  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'Pricing Database'
 
	 UPDATE [Pricing Database] 
	 SET   
		[ProductID] = @ProductID, 
		[Height] = @Height, 
		[Width] = @Width, 
		[Depth] = @Depth, 
		[Volume] = @Volume, 
		[BasePrice] = @BasePrice, 
		[BasePrice2S] = @BasePrice2S, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Pricing Database]( [ID], [StoreID], [ProductID], [Height], [Width], [Depth], [Volume], [BasePrice], [BasePrice2S], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ProductID, @Height, @Width, @Depth, @Volume, @BasePrice, @BasePrice2S, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
