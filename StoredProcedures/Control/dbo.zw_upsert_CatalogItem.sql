/****** Object:  StoredProcedure [dbo].[zw_upsert_CatalogItem]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_CatalogItem] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PartID int  = NULL , 
@VendorID int  = NULL , 
@BarCode varchar(50)  = NULL , 
@Cost float  = NULL , 
@PackageSize float  = NULL , 
@PackageUnitID int  = NULL , 
@UnitCost float  = NULL , 
@VendorPartName varchar(50)  = NULL , 
@PartNumber varchar(50)  = NULL , 
@VendorPriority int  = NULL , 
@Flags [nvarchar](MAX)   = NULL , 
@BillingNotes [nvarchar](MAX)   = NULL , 
@ProductionNotes [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CatalogItem] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[PartID] = @PartID, 
		[VendorID] = @VendorID, 
		[BarCode] = @BarCode, 
		[Cost] = @Cost, 
		[PackageSize] = @PackageSize, 
		[PackageUnitID] = @PackageUnitID, 
		[UnitCost] = @UnitCost, 
		[VendorPartName] = @VendorPartName, 
		[PartNumber] = @PartNumber, 
		[VendorPriority] = @VendorPriority, 
		[Flags] = @Flags, 
		[BillingNotes] = @BillingNotes, 
		[ProductionNotes] = @ProductionNotes, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [CatalogItem]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [PartID], [VendorID], [BarCode], [Cost], [PackageSize], [PackageUnitID], [UnitCost], [VendorPartName], [PartNumber], [VendorPriority], [Flags], [BillingNotes], [ProductionNotes], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @PartID, @VendorID, @BarCode, @Cost, @PackageSize, @PackageUnitID, @UnitCost, @VendorPartName, @PartNumber, @VendorPriority, @Flags, @BillingNotes, @ProductionNotes, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
