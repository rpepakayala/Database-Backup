/****** Object:  StoredProcedure [dbo].[zw_delete_Variable]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_delete_Variable] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@VariableName varchar(50)  = NULL , 
@ParentID int  = NULL , 
@ParentStoreID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@VariableType int  = NULL , 
@InputUnitID int  = NULL , 
@OutputUnitID int  = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@IsRequired bit  = NULL , 
@TextValue varchar(50)  = NULL , 
@NumberValue float  = NULL , 
@UseFormula bit  = NULL , 
@Formula [nvarchar](MAX)   = NULL , 
@MaxValue float  = NULL , 
@MinValue float  = NULL , 
@SelectionListID int  = NULL , 
@SelectionListStoreID int  = NULL , 
@SelectionListClassTypeID int  = NULL , 
@UseSecondaryList bit  = NULL , 
@SecondaryListVariableID int  = NULL , 
@SecondaryListVariableStoreID int  = NULL , 
@SecondaryListVariableClassTypeID int  = NULL , 
@IsLimitedToList bit  = NULL , 
@Part2ConsumptionFormula [nvarchar](MAX)   = NULL , 
@PartConsumptionFormula [nvarchar](MAX)   = NULL , 
@IsModifierVariable bit  = NULL , 
@SaveTransRecord bit  = NULL , 
@SystemListType int  = NULL , 
@UnitType int  = NULL , 
@PricingPlanID int  = NULL , 
@PricingPlanStoreID int  = NULL , 
@PricingPlanClassTypeID int  = NULL , 
@PricingTableID int  = NULL , 
@PricingTableStoreID int  = NULL , 
@PricingTableClassTypeID int  = NULL , 
@PartDescription [nvarchar](MAX)   = NULL , 
@Part2Description [nvarchar](MAX)   = NULL , 
@AltDependentListName varchar(40)  = NULL , 
@UseRequiredFormula bit  = NULL , 
@IsRequiredFormula [nvarchar](MAX)   = NULL , 
@SelectionListFilterName varchar(40)  = NULL , 
@PartConsumptionFormulas [nvarchar](MAX)   = NULL , 
@UseMaxValueFormula bit  = NULL , 
@MaxValueFormula [nvarchar](MAX)   = NULL , 
@UseMinValueFormula bit  = NULL , 
@MinValueFormula [nvarchar](MAX)   = NULL , 
@ImageLinkName varchar(40)  = NULL , 
@ImageSaveType int  = NULL , 
@ResetOnClone bit  = NULL , 
@PartConsumptionUnitIDs [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Variable] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID


GO
