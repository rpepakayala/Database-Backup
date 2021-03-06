/****** Object:  StoredProcedure [dbo].[zw_delete_PaymentTermsDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_PaymentTermsDatabase ( 
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
 
	 UPDATE [PaymentTermsDatabase] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [PaymentTermsID] = @PaymentTermsID

GO
