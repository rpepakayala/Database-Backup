/****** Object:  StoredProcedure [dbo].[zw_delete_PricingDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_PricingDatabase ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ProductID int  = NULL , 
@Height float  = NULL , 
@Width float  = NULL , 
@Depth float  = NULL , 
@Volume float  = NULL , 
@BasePrice float  = NULL , 
@BasePrice2S float  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Pricing Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID

GO
