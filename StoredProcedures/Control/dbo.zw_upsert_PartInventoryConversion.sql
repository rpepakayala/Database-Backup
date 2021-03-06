/****** Object:  StoredProcedure [dbo].[zw_upsert_PartInventoryConversion]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_PartInventoryConversion ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PartID int  = NULL , 
@IsAutomatic bit  = NULL , 
@IsDefault bit  = NULL , 
@ConversionFormula [nvarchar](MAX)   = NULL , 
@ConsumptionFormula [nvarchar](MAX)   = NULL , 
@InclusionFormula [nvarchar](MAX)   = NULL , 
@UnitID int  = NULL , 
@UnitType int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PartInventoryConversion] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[PartID] = @PartID, 
		[IsAutomatic] = @IsAutomatic, 
		[IsDefault] = @IsDefault, 
		[ConversionFormula] = @ConversionFormula, 
		[ConsumptionFormula] = @ConsumptionFormula, 
		[InclusionFormula] = @InclusionFormula, 
		[UnitID] = @UnitID, 
		[UnitType] = @UnitType, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PartInventoryConversion]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [PartID], [IsAutomatic], [IsDefault], [ConversionFormula], [ConsumptionFormula], [InclusionFormula], [UnitID], [UnitType], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @PartID, @IsAutomatic, @IsDefault, @ConversionFormula, @ConsumptionFormula, @InclusionFormula, @UnitID, @UnitType, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
