/****** Object:  StoredProcedure [dbo].[zw_upsert_TaxAccount]    Script Date: 5/15/2018 12:09:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_TaxAccount ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@TaxRate [decimal](18,5)  = NULL , 
@CapAmount [decimal](18,5)  = NULL , 
@ReferenceID [nvarchar](50)   = NULL , 
@AlwaysRoundUp bit  = NULL , 
@AddressID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [TaxAccount] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[TaxRate] = @TaxRate, 
		[CapAmount] = @CapAmount, 
		[ReferenceID] = @ReferenceID, 
		[AlwaysRoundUp] = @AlwaysRoundUp, 
		[AddressID] = @AddressID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [TaxAccount]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [TaxRate], [CapAmount], [ReferenceID], [AlwaysRoundUp], [AddressID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @TaxRate, @CapAmount, @ReferenceID, @AlwaysRoundUp, @AddressID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
