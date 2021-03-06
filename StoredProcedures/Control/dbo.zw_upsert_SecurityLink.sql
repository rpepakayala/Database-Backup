/****** Object:  StoredProcedure [dbo].[zw_upsert_SecurityLink]    Script Date: 5/15/2018 12:09:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_SecurityLink ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@LeftID int  = NULL , 
@LeftStoreID int  = NULL , 
@LeftClassTypeID int  = NULL , 
@RightID int  = NULL , 
@RightStoreID int  = NULL , 
@RightClassTypeID int  = NULL , 
@LinkIndex int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [SecurityLink] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[LeftID] = @LeftID, 
		[LeftStoreID] = @LeftStoreID, 
		[LeftClassTypeID] = @LeftClassTypeID, 
		[RightID] = @RightID, 
		[RightStoreID] = @RightStoreID, 
		[RightClassTypeID] = @RightClassTypeID, 
		[LinkIndex] = @LinkIndex, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [SecurityLink]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [LeftID], [LeftStoreID], [LeftClassTypeID], [RightID], [RightStoreID], [RightClassTypeID], [LinkIndex], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @LeftID, @LeftStoreID, @LeftClassTypeID, @RightID, @RightStoreID, @RightClassTypeID, @LinkIndex, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
