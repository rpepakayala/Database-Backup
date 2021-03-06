/****** Object:  StoredProcedure [dbo].[zw_delete_AdjustmentDatabase]    Script Date: 5/15/2018 12:09:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_AdjustmentDatabase ( 
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
 
	 UPDATE [Adjustment Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [AdjustmentID] = @AdjustmentID
		AND [StoreID] = @StoreID

GO
