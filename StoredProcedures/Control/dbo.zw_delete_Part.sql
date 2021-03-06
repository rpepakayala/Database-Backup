/****** Object:  StoredProcedure [dbo].[zw_delete_Part]    Script Date: 5/15/2018 12:09:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_Part ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@CategoryID int  = NULL , 
@CategoryStoreID int  = NULL , 
@CategoryClassTypeID int  = NULL , 
@ItemName [nvarchar](50)   = NULL , 
@Description [nvarchar](MAX)   = NULL , 
@HelpText [nvarchar](MAX)   = NULL , 
@InternalNotes [nvarchar](MAX)   = NULL , 
@BarCode [nvarchar](50)   = NULL , 
@SKU [nvarchar](50)   = NULL , 
@AssetAccountID int  = NULL , 
@ExpenseAccountID int  = NULL , 
@InventoryUnitType int  = NULL , 
@PartType int  = NULL , 
@TrackInventory bit  = NULL , 
@QuantityOnHand float  = NULL , 
@QuantityReserved float  = NULL , 
@QuantityAvailable float  = NULL , 
@QuantityOnOrder float  = NULL , 
@QuantityExpected float  = NULL , 
@ReOrderPoint float  = NULL , 
@ReOrderQuantity float  = NULL , 
@YellowNotificationPoint float  = NULL , 
@RedNotificationPoint float  = NULL , 
@NotificationAddresses [nvarchar](MAX)   = NULL , 
@NotifyOtherContacts bit  = NULL , 
@UnitID int  = NULL , 
@RoundingOption int  = NULL , 
@ScrapFactor float  = NULL , 
@UnitCost float  = NULL , 
@TrackCosts bit  = NULL , 
@UnitCostFormula [nvarchar](MAX)   = NULL , 
@UseFixedCost bit  = NULL , 
@CostMultiplier [nvarchar](MAX)   = NULL , 
@CostMultiplierType int  = NULL , 
@FixedCostMultiplier [nvarchar](MAX)   = NULL , 
@ShowOnProductionSchedule bit  = NULL , 
@InstancesAllowedType int  = NULL , 
@InstancesAllowed int  = NULL , 
@Vendor varchar(40)  = NULL , 
@VendorPartNumber varchar(40)  = NULL , 
@RoundingFactor float  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Part] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
