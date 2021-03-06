/****** Object:  StoredProcedure [dbo].[zw_upsert_PaymentAccount]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_PaymentAccount ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@MaxChange [decimal](18,4)  = NULL , 
@DiscountRate [decimal](18,4)  = NULL , 
@ReturnDiscountRate [decimal](18,4)  = NULL , 
@CanGiveCashBack bit  = NULL , 
@CreditCardType int  = NULL , 
@TenderType int  = NULL , 
@ImageID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PaymentAccount] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[MaxChange] = @MaxChange, 
		[DiscountRate] = @DiscountRate, 
		[ReturnDiscountRate] = @ReturnDiscountRate, 
		[CanGiveCashBack] = @CanGiveCashBack, 
		[CreditCardType] = @CreditCardType, 
		[TenderType] = @TenderType, 
		[ImageID] = @ImageID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PaymentAccount]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [MaxChange], [DiscountRate], [ReturnDiscountRate], [CanGiveCashBack], [CreditCardType], [TenderType], [ImageID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @MaxChange, @DiscountRate, @ReturnDiscountRate, @CanGiveCashBack, @CreditCardType, @TenderType, @ImageID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
