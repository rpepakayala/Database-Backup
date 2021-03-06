/****** Object:  StoredProcedure [dbo].[zw_delete_PaymentGroupsDatabase]    Script Date: 5/15/2018 12:09:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_PaymentGroupsDatabase ( 
@PaymentMethodType int  = NULL , 
@StoreID int  = NULL , 
@GroupName varchar(15)   = NULL , 
@DefaultAccountCode int  = NULL , 
@Text varchar(50)   = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Payment Groups Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [PaymentMethodType] = @PaymentMethodType
		AND [StoreID] = @StoreID

GO
