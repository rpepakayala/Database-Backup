/****** Object:  StoredProcedure [dbo].[zw_upsert_Payment]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_Payment ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@NameOnCard [nvarchar](25)   = NULL , 
@TrackingNumber [nvarchar](25)   = NULL , 
@PaymentAccountID int  = NULL , 
@PaymentAccountClassTypeID int  = NULL , 
@ExpirationDate datetime  = NULL , 
@VCode varchar(10)  = NULL , 
@IsCCNumEncrypt bit  = NULL , 
@DisplayNumber varchar(50)  = NULL , 
@IsVCodeEncrypted bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Payment] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[NameOnCard] = @NameOnCard, 
		[TrackingNumber] = @TrackingNumber, 
		[PaymentAccountID] = @PaymentAccountID, 
		[PaymentAccountClassTypeID] = @PaymentAccountClassTypeID, 
		[ExpirationDate] = @ExpirationDate, 
		[VCode] = @VCode, 
		[IsCCNumEncrypt] = @IsCCNumEncrypt, 
		[DisplayNumber] = @DisplayNumber, 
		[IsVCodeEncrypted] = @IsVCodeEncrypted, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Payment]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [NameOnCard], [TrackingNumber], [PaymentAccountID], [PaymentAccountClassTypeID], [ExpirationDate], [VCode], [IsCCNumEncrypt], [DisplayNumber], [IsVCodeEncrypted], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @NameOnCard, @TrackingNumber, @PaymentAccountID, @PaymentAccountClassTypeID, @ExpirationDate, @VCode, @IsCCNumEncrypt, @DisplayNumber, @IsVCodeEncrypted, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
