/****** Object:  StoredProcedure [dbo].[zw_upsert_AdjustmentDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_AdjustmentDatabase ( 
@AdjustmentID int  = NULL , 
@StoreID int  = NULL , 
@OrderID int  = NULL , 
@CustomerID int  = NULL , 
@EstimateID int  = NULL , 
@AdjustmentDate datetime  = NULL , 
@AdjustedBy int  = NULL , 
@Amount float  = NULL , 
@Reason varchar(50)   = NULL , 
@ReasonCode varchar(50)   = NULL , 
@OrderStatus varchar(12)   = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'Adjustment Database'
 
	 UPDATE [Adjustment Database] 
	 SET   
		[OrderID] = @OrderID, 
		[CustomerID] = @CustomerID, 
		[EstimateID] = @EstimateID, 
		[AdjustmentDate] = @AdjustmentDate, 
		[AdjustedBy] = @AdjustedBy, 
		[Amount] = @Amount, 
		[Reason] = @Reason, 
		[ReasonCode] = @ReasonCode, 
		[OrderStatus] = @OrderStatus, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [AdjustmentID] = @AdjustmentID
		AND [StoreID] = @StoreID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Adjustment Database]( [AdjustmentID], [StoreID], [OrderID], [CustomerID], [EstimateID], [AdjustmentDate], [AdjustedBy], [Amount], [Reason], [ReasonCode], [OrderStatus], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @AdjustmentID, @StoreID, @OrderID, @CustomerID, @EstimateID, @AdjustmentDate, @AdjustedBy, @Amount, @Reason, @ReasonCode, @OrderStatus, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
