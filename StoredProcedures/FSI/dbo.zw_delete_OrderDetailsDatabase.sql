/****** Object:  StoredProcedure [dbo].[zw_delete_OrderDetailsDatabase]    Script Date: 5/15/2018 12:09:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_OrderDetailsDatabase ( 
@OrderDetailID int  = NULL , 
@StoreID int  = NULL , 
@LineItemNumber int  = NULL , 
@OrderID int  = NULL , 
@ProductID int  = NULL , 
@ProductCode varchar(30)   = NULL , 
@Quantity float  = NULL , 
@Sides float  = NULL , 
@Height float  = NULL , 
@Width float  = NULL , 
@ForegroundColor varchar(100)   = NULL , 
@BackgroundColor varchar(100)   = NULL , 
@Font varchar(100)   = NULL , 
@BasePrice float  = NULL , 
@BasePriceOverriden bit  = NULL , 
@BasePriceCalculated float  = NULL , 
@AVTotal float  = NULL , 
@InstallAmount float  = NULL , 
@DiscountPercentage float  = NULL , 
@DiscountAmount float  = NULL , 
@ItemTotal float  = NULL , 
@UnitPriceOverridden bit  = NULL , 
@OverRidden bit  = NULL , 
@ItemTotalCalculated float  = NULL , 
@Taxable bit  = NULL , 
@AllInstallation bit  = NULL , 
@Description varchar(MAX)   = NULL , 
@SignText varchar(MAX)   = NULL , 
@AVIDS varbinary(100)  = NULL , 
@AVValues varbinary(25)  = NULL , 
@AVAdditionalAmt float  = NULL , 
@AVAdditionalDescription varchar(25)   = NULL , 
@AVOverridden bit  = NULL , 
@AVCalculated float  = NULL , 
@ProductionLocation int  = NULL , 
@ShopTime float  = NULL , 
@FieldTime float  = NULL , 
@FieldCrewSize float  = NULL , 
@MaterialCost float  = NULL , 
@HeightAboveGround float  = NULL , 
@OtherInstallConsideration float  = NULL , 
@SpecialEquipment1 bit  = NULL , 
@SpecialEquipment2 bit  = NULL , 
@SpecialEquipment3 bit  = NULL , 
@SpecialEquipmentOther bit  = NULL , 
@SpecialEquipmentOtherAmou float  = NULL , 
@EstimatedInstallCharge float  = NULL , 
@AccountCode int  = NULL , 
@Hidden bit  = NULL , 
@PMsAnswered bit  = NULL , 
@ParentItemNumber int  = NULL , 
@ChildLevel int  = NULL , 
@BaseCost float  = NULL , 
@ProductionNotes varchar(MAX)   = NULL , 
@HasChildren bit  = NULL , 
@BaseSonsPrice float  = NULL , 
@BaseMeAndSonsPrice float  = NULL , 
@InstallSonsPrice float  = NULL , 
@InstallMeAndSonsPrice float  = NULL , 
@DiscountSonsPrice float  = NULL , 
@DiscountMeAndSonsPrice float  = NULL , 
@ItemTotalSonsPrice float  = NULL , 
@ItemTotalMeAndSonsPrice float  = NULL , 
@ModifierXML varchar(MAX)   = NULL , 
@RoyaltyGroupID int  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Order Details Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [OrderDetailID] = @OrderDetailID
		AND [StoreID] = @StoreID

GO
