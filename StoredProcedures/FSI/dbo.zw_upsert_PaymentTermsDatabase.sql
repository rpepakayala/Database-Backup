/****** Object:  StoredProcedure [dbo].[zw_upsert_PaymentTermsDatabase]    Script Date: 5/15/2018 12:09:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_PaymentTermsDatabase ( 
@PaymentTermsID int  = NULL , 
@Terms varchar(20)   = NULL , 
@Message varchar(MAX)   = NULL , 
@DiscountDays int  = NULL , 
@DiscountRate float  = NULL , 
@LateDays int  = NULL , 
@InterestFee float  = NULL , 
@LateFromDueDate bit  = NULL , 
@InterestOnInterest bit  = NULL , 
@AccountCode int  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'PaymentTermsDatabase'
 
	 UPDATE [PaymentTermsDatabase] 
	 SET   
		[Terms] = @Terms, 
		[Message] = @Message, 
		[DiscountDays] = @DiscountDays, 
		[DiscountRate] = @DiscountRate, 
		[LateDays] = @LateDays, 
		[InterestFee] = @InterestFee, 
		[LateFromDueDate] = @LateFromDueDate, 
		[InterestOnInterest] = @InterestOnInterest, 
		[AccountCode] = @AccountCode, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [PaymentTermsID] = @PaymentTermsID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PaymentTermsDatabase]( [PaymentTermsID], [Terms], [Message], [DiscountDays], [DiscountRate], [LateDays], [InterestFee], [LateFromDueDate], [InterestOnInterest], [AccountCode], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @PaymentTermsID, @Terms, @Message, @DiscountDays, @DiscountRate, @LateDays, @InterestFee, @LateFromDueDate, @InterestOnInterest, @AccountCode, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
