/****** Object:  StoredProcedure [dbo].[zw_delete_RoyaltyGroupDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_RoyaltyGroupDatabase ( 
@RoyaltyGroupID int  = NULL , 
@StoreID int  = NULL , 
@GroupName varchar(50)   = NULL , 
@Description varchar(MAX)   = NULL , 
@IsActive bit  = NULL , 
@AvailableToUser bit  = NULL , 
@RoyaltyRate float  = NULL , 
@AdvertisingRate float  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Royalty Group Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [RoyaltyGroupID] = @RoyaltyGroupID
		AND [StoreID] = @StoreID

GO
