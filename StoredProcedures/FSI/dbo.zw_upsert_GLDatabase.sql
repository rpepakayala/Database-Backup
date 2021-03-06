/****** Object:  StoredProcedure [dbo].[zw_upsert_GLDatabase]    Script Date: 5/15/2018 12:09:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_GLDatabase ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@DateTime datetime  = NULL , 
@OrderID int  = NULL , 
@CustomerID int  = NULL , 
@RecordID int  = NULL , 
@AccountCode int  = NULL , 
@UserID int  = NULL , 
@Amount float  = NULL , 
@Description varchar(25)   = NULL , 
@Closed bit  = NULL , 
@ClosedDate datetime  = NULL , 
@Exported bit  = NULL , 
@ExportedDate datetime  = NULL , 
@ExportedBatch int  = NULL , 
@EnteredByID int  = NULL , 
@SubAccountCode int  = NULL , 
@Taxable bit  = NULL , 
@Consolidated bit  = NULL , 
@Category int  = NULL , 
@RoyaltyGroupID int  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@OrderDetailID int  = NULL , 
@ProductID int  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'GL Database'
 
	 UPDATE [GL Database] 
	 SET   
		[DateTime] = @DateTime, 
		[OrderID] = @OrderID, 
		[CustomerID] = @CustomerID, 
		[RecordID] = @RecordID, 
		[AccountCode] = @AccountCode, 
		[UserID] = @UserID, 
		[Amount] = @Amount, 
		[Description] = @Description, 
		[Closed] = @Closed, 
		[ClosedDate] = @ClosedDate, 
		[Exported] = @Exported, 
		[ExportedDate] = @ExportedDate, 
		[ExportedBatch] = @ExportedBatch, 
		[EnteredByID] = @EnteredByID, 
		[SubAccountCode] = @SubAccountCode, 
		[Taxable] = @Taxable, 
		[Consolidated] = @Consolidated, 
		[Category] = @Category, 
		[RoyaltyGroupID] = @RoyaltyGroupID, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[OrderDetailID] = @OrderDetailID, 
		[ProductID] = @ProductID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [GL Database]( [ID], [StoreID], [DateTime], [OrderID], [CustomerID], [RecordID], [AccountCode], [UserID], [Amount], [Description], [Closed], [ClosedDate], [Exported], [ExportedDate], [ExportedBatch], [EnteredByID], [SubAccountCode], [Taxable], [Consolidated], [Category], [RoyaltyGroupID], [ModifiedByComputer], [ModifiedDate], [OrderDetailID], [ProductID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @DateTime, @OrderID, @CustomerID, @RecordID, @AccountCode, @UserID, @Amount, @Description, @Closed, @ClosedDate, @Exported, @ExportedDate, @ExportedBatch, @EnteredByID, @SubAccountCode, @Taxable, @Consolidated, @Category, @RoyaltyGroupID, @ModifiedByComputer, @ModifiedDate, @OrderDetailID, @ProductID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
