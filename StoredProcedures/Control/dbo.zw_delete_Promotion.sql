/****** Object:  StoredProcedure [dbo].[zw_delete_Promotion]    Script Date: 5/15/2018 12:09:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_Promotion ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PromotionName varchar(25)  = NULL , 
@Description [nvarchar](MAX)   = NULL , 
@IsAlwaysValid bit  = NULL , 
@ValidStartDateTime datetime  = NULL , 
@ValidEndDateTime datetime  = NULL , 
@PromotionType int  = NULL , 
@PercentageOff float  = NULL , 
@FixedDiscount float  = NULL , 
@SaleAccountID int  = NULL , 
@SaleAccountStoreID int  = NULL , 
@SaleAccountClassTypeID int  = NULL , 
@AllowOrderEdit bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Promotion] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
