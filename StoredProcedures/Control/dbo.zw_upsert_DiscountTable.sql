/****** Object:  StoredProcedure [dbo].[zw_upsert_DiscountTable]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_DiscountTable ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ParameterID int  = NULL , 
@ParameterClassTypeID int  = NULL , 
@DiscountTableName [nvarchar](25)   = NULL , 
@DiscountType int  = NULL , 
@UnitID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [DiscountTable] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ParameterID] = @ParameterID, 
		[ParameterClassTypeID] = @ParameterClassTypeID, 
		[DiscountTableName] = @DiscountTableName, 
		[DiscountType] = @DiscountType, 
		[UnitID] = @UnitID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [DiscountTable]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ParameterID], [ParameterClassTypeID], [DiscountTableName], [DiscountType], [UnitID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ParameterID, @ParameterClassTypeID, @DiscountTableName, @DiscountType, @UnitID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
