/****** Object:  StoredProcedure [dbo].[zw_delete_PaymentMethodsDatabase]    Script Date: 5/15/2018 12:09:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_PaymentMethodsDatabase ( 
@PaymentMethodID int  = NULL , 
@PaymentMethod varchar(12)   = NULL , 
@PaymentMethodType int  = NULL , 
@AccountCode int  = NULL , 
@Text varchar(50)   = NULL , 
@ActiveMethod bit  = NULL , 
@ProcessOnline bit  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Payment Methods Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [PaymentMethodID] = @PaymentMethodID

GO
