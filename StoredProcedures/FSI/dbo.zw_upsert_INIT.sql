/****** Object:  StoredProcedure [dbo].[zw_upsert_INIT]    Script Date: 5/15/2018 12:09:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_INIT ( 
@OrderID int  = NULL , 
@CustomerID int  = NULL , 
@Amount float  = NULL , 
@TheDate datetime  = NULL , 
@TheTime datetime  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'INIT'
 
	SET @OrderID = COALESCE(@OrderID,0)
	SET @CustomerID = COALESCE(@CustomerID,0)
 
	 UPDATE [INIT] 
	 SET   
		[Amount] = @Amount, 
		[TheDate] = @TheDate, 
		[TheTime] = @TheTime, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [OrderID] = @OrderID
		AND [CustomerID] = @CustomerID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [INIT]( [OrderID], [CustomerID], [Amount], [TheDate], [TheTime], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @OrderID, @CustomerID, @Amount, @TheDate, @TheTime, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
