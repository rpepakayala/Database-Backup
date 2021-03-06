/****** Object:  StoredProcedure [dbo].[zw_delete_PromotionDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_PromotionDatabase ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@Promotion varchar(30)   = NULL , 
@DiscountPercent float  = NULL , 
@DiscountAmount float  = NULL , 
@MinimumPurchase float  = NULL , 
@ActivePromotion bit  = NULL , 
@StartDate datetime  = NULL , 
@EndDate datetime  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Promotion Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID

GO
