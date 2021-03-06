/****** Object:  StoredProcedure [dbo].[zw_upsert_GoodsItemPartLink]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_GoodsItemPartLink ( 
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
@GoodsItemID int  = NULL , 
@GoodsItemClassTypeID int  = NULL , 
@ConsumptionFormula [nvarchar](MAX)   = NULL , 
@InclusionFormula [nvarchar](MAX)   = NULL , 
@IncludeAlways bit  = NULL , 
@ConsumptionUnitID int  = NULL , 
@Description [nvarchar](MAX)   = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [GoodsItemPartLink] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[PartID] = @PartID, 
		[GoodsItemID] = @GoodsItemID, 
		[GoodsItemClassTypeID] = @GoodsItemClassTypeID, 
		[ConsumptionFormula] = @ConsumptionFormula, 
		[InclusionFormula] = @InclusionFormula, 
		[IncludeAlways] = @IncludeAlways, 
		[ConsumptionUnitID] = @ConsumptionUnitID, 
		[Description] = @Description, 
		[Notes] = @Notes, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [GoodsItemPartLink]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [PartID], [GoodsItemID], [GoodsItemClassTypeID], [ConsumptionFormula], [InclusionFormula], [IncludeAlways], [ConsumptionUnitID], [Description], [Notes], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @PartID, @GoodsItemID, @GoodsItemClassTypeID, @ConsumptionFormula, @InclusionFormula, @IncludeAlways, @ConsumptionUnitID, @Description, @Notes, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
