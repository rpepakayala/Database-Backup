/****** Object:  StoredProcedure [dbo].[zw_delete_CommissionRate]    Script Date: 5/15/2018 12:09:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_delete_CommissionRate] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PricingPlanTypeID int  = NULL , 
@CommissionPlanID int  = NULL , 
@Rate1Salesperson1 float  = NULL , 
@Rate2Salesperson1 float  = NULL , 
@Rate2Salesperson2 float  = NULL , 
@Rate3Salesperson1 float  = NULL , 
@Rate3Salesperson2 float  = NULL , 
@Rate3Salesperson3 float  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CommissionRate] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID


GO
