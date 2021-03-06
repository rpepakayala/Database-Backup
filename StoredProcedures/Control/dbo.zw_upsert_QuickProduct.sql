/****** Object:  StoredProcedure [dbo].[zw_upsert_QuickProduct]    Script Date: 5/15/2018 12:09:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_QuickProduct] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ProductID int  = NULL , 
@ImageID int  = NULL , 
@ImageStoreID int  = NULL , 
@ImageClassTypeID int  = NULL , 
@ParentID int  = NULL , 
@LinkIndex int  = NULL , 
@ProductClassTypeID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [QuickProduct] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ProductID] = @ProductID, 
		[ImageID] = @ImageID, 
		[ImageStoreID] = @ImageStoreID, 
		[ImageClassTypeID] = @ImageClassTypeID, 
		[ParentID] = @ParentID, 
		[LinkIndex] = @LinkIndex, 
		[ProductClassTypeID] = @ProductClassTypeID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [QuickProduct]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ProductID], [ImageID], [ImageStoreID], [ImageClassTypeID], [ParentID], [LinkIndex], [ProductClassTypeID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ProductID, @ImageID, @ImageStoreID, @ImageClassTypeID, @ParentID, @LinkIndex, @ProductClassTypeID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
