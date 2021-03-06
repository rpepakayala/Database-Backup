/****** Object:  StoredProcedure [dbo].[zw_upsert_Part]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_Part ( 
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
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[CategoryID] = @CategoryID, 
		[CategoryStoreID] = @CategoryStoreID, 
		[CategoryClassTypeID] = @CategoryClassTypeID, 
		[ItemName] = @ItemName, 
		[Description] = @Description, 
		[HelpText] = @HelpText, 
		[InternalNotes] = @InternalNotes, 
		[BarCode] = @BarCode, 
		[SKU] = @SKU, 
		[AssetAccountID] = @AssetAccountID, 
		[ExpenseAccountID] = @ExpenseAccountID, 
		[InventoryUnitType] = @InventoryUnitType, 
		[PartType] = @PartType, 
		[TrackInventory] = @TrackInventory, 
		[QuantityOnHand] = @QuantityOnHand, 
		[QuantityReserved] = @QuantityReserved, 
		[QuantityAvailable] = @QuantityAvailable, 
		[QuantityOnOrder] = @QuantityOnOrder, 
		[QuantityExpected] = @QuantityExpected, 
		[ReOrderPoint] = @ReOrderPoint, 
		[ReOrderQuantity] = @ReOrderQuantity, 
		[YellowNotificationPoint] = @YellowNotificationPoint, 
		[RedNotificationPoint] = @RedNotificationPoint, 
		[NotificationAddresses] = @NotificationAddresses, 
		[NotifyOtherContacts] = @NotifyOtherContacts, 
		[UnitID] = @UnitID, 
		[RoundingOption] = @RoundingOption, 
		[ScrapFactor] = @ScrapFactor, 
		[UnitCost] = @UnitCost, 
		[TrackCosts] = @TrackCosts, 
		[UnitCostFormula] = @UnitCostFormula, 
		[UseFixedCost] = @UseFixedCost, 
		[CostMultiplier] = @CostMultiplier, 
		[CostMultiplierType] = @CostMultiplierType, 
		[FixedCostMultiplier] = @FixedCostMultiplier, 
		[ShowOnProductionSchedule] = @ShowOnProductionSchedule, 
		[InstancesAllowedType] = @InstancesAllowedType, 
		[InstancesAllowed] = @InstancesAllowed, 
		[Vendor] = @Vendor, 
		[VendorPartNumber] = @VendorPartNumber, 
		[RoundingFactor] = @RoundingFactor, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Part]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [CategoryID], [CategoryStoreID], [CategoryClassTypeID], [ItemName], [Description], [HelpText], [InternalNotes], [BarCode], [SKU], [AssetAccountID], [ExpenseAccountID], [InventoryUnitType], [PartType], [TrackInventory], [QuantityOnHand], [QuantityReserved], [QuantityAvailable], [QuantityOnOrder], [QuantityExpected], [ReOrderPoint], [ReOrderQuantity], [YellowNotificationPoint], [RedNotificationPoint], [NotificationAddresses], [NotifyOtherContacts], [UnitID], [RoundingOption], [ScrapFactor], [UnitCost], [TrackCosts], [UnitCostFormula], [UseFixedCost], [CostMultiplier], [CostMultiplierType], [FixedCostMultiplier], [ShowOnProductionSchedule], [InstancesAllowedType], [InstancesAllowed], [Vendor], [VendorPartNumber], [RoundingFactor], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @CategoryID, @CategoryStoreID, @CategoryClassTypeID, @ItemName, @Description, @HelpText, @InternalNotes, @BarCode, @SKU, @AssetAccountID, @ExpenseAccountID, @InventoryUnitType, @PartType, @TrackInventory, @QuantityOnHand, @QuantityReserved, @QuantityAvailable, @QuantityOnOrder, @QuantityExpected, @ReOrderPoint, @ReOrderQuantity, @YellowNotificationPoint, @RedNotificationPoint, @NotificationAddresses, @NotifyOtherContacts, @UnitID, @RoundingOption, @ScrapFactor, @UnitCost, @TrackCosts, @UnitCostFormula, @UseFixedCost, @CostMultiplier, @CostMultiplierType, @FixedCostMultiplier, @ShowOnProductionSchedule, @InstancesAllowedType, @InstancesAllowed, @Vendor, @VendorPartNumber, @RoundingFactor, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
