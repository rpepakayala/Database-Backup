/****** Object:  StoredProcedure [dbo].[zw_upsert_PricingTable]    Script Date: 5/15/2018 12:09:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_PricingTable ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@RowCount int  = NULL , 
@ColCount int  = NULL , 
@IsSymmetricTable bit  = NULL , 
@RowParam1ID int  = NULL , 
@RowParam1ClassTypeID int  = NULL , 
@RowParam2ID int  = NULL , 
@RowParam2ClassTypeID int  = NULL , 
@ColParamID int  = NULL , 
@ColParamClassTypeID int  = NULL , 
@OnRowNotFound int  = NULL , 
@OnRowOutOfBounds int  = NULL , 
@OnColNotFound int  = NULL , 
@TableElementStr [nvarchar](MAX)   = NULL , 
@PricingTableName varchar(50)  = NULL , 
@CategoryID int  = NULL , 
@CategoryStoreID int  = NULL , 
@CategoryClassTypeID int  = NULL , 
@Row1UnitID int  = NULL , 
@Row2UnitID int  = NULL , 
@ColUnitID int  = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PricingTable] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[RowCount] = @RowCount, 
		[ColCount] = @ColCount, 
		[IsSymmetricTable] = @IsSymmetricTable, 
		[RowParam1ID] = @RowParam1ID, 
		[RowParam1ClassTypeID] = @RowParam1ClassTypeID, 
		[RowParam2ID] = @RowParam2ID, 
		[RowParam2ClassTypeID] = @RowParam2ClassTypeID, 
		[ColParamID] = @ColParamID, 
		[ColParamClassTypeID] = @ColParamClassTypeID, 
		[OnRowNotFound] = @OnRowNotFound, 
		[OnRowOutOfBounds] = @OnRowOutOfBounds, 
		[OnColNotFound] = @OnColNotFound, 
		[TableElementStr] = @TableElementStr, 
		[PricingTableName] = @PricingTableName, 
		[CategoryID] = @CategoryID, 
		[CategoryStoreID] = @CategoryStoreID, 
		[CategoryClassTypeID] = @CategoryClassTypeID, 
		[Row1UnitID] = @Row1UnitID, 
		[Row2UnitID] = @Row2UnitID, 
		[ColUnitID] = @ColUnitID, 
		[Notes] = @Notes, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PricingTable]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [RowCount], [ColCount], [IsSymmetricTable], [RowParam1ID], [RowParam1ClassTypeID], [RowParam2ID], [RowParam2ClassTypeID], [ColParamID], [ColParamClassTypeID], [OnRowNotFound], [OnRowOutOfBounds], [OnColNotFound], [TableElementStr], [PricingTableName], [CategoryID], [CategoryStoreID], [CategoryClassTypeID], [Row1UnitID], [Row2UnitID], [ColUnitID], [Notes], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @RowCount, @ColCount, @IsSymmetricTable, @RowParam1ID, @RowParam1ClassTypeID, @RowParam2ID, @RowParam2ClassTypeID, @ColParamID, @ColParamClassTypeID, @OnRowNotFound, @OnRowOutOfBounds, @OnColNotFound, @TableElementStr, @PricingTableName, @CategoryID, @CategoryStoreID, @CategoryClassTypeID, @Row1UnitID, @Row2UnitID, @ColUnitID, @Notes, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
