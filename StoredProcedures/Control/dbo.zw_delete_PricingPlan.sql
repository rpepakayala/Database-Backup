/****** Object:  StoredProcedure [dbo].[zw_delete_PricingPlan]    Script Date: 5/15/2018 12:09:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_PricingPlan ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PricingPlanTypeID int  = NULL , 
@GoodsItemID int  = NULL , 
@GoodsItemClassTypeID int  = NULL , 
@SetUpFormula [nvarchar](MAX)   = NULL , 
@BaseMinimum [nvarchar](MAX)   = NULL , 
@OverallMinimum [nvarchar](MAX)   = NULL , 
@RoundingFactor [decimal](18,4)  = NULL , 
@CommissionPlanID int  = NULL , 
@RoyaltyPlanID int  = NULL , 
@ScreenTemplateID int  = NULL , 
@WebInputTemplateID int  = NULL , 
@InvoiceTemplateID int  = NULL , 
@EstimateTemplateID int  = NULL , 
@WorkOrderTemplateID int  = NULL , 
@EmployeeWebOutputTemplateID int  = NULL , 
@CustomerWebOutputTemplateID int  = NULL , 
@QtyDiscountTableID int  = NULL , 
@OverallDiscountTableID int  = NULL , 
@PerPieceMinimum [nvarchar](MAX)   = NULL , 
@UseCustomPriceMethod bit  = NULL , 
@UnitPriceParameterID int  = NULL , 
@UnitPriceParameterClassTypeID int  = NULL , 
@OverheadFormula [nvarchar](MAX)   = NULL , 
@MaterialCostFormula [nvarchar](MAX)   = NULL , 
@LaborCostFormula [nvarchar](MAX)   = NULL , 
@EquipmentCostFormula [nvarchar](MAX)   = NULL , 
@OutsourceCostFormula [nvarchar](MAX)   = NULL , 
@OtherCostFormula [nvarchar](MAX)   = NULL , 
@IncludeModifierCost bit  = NULL , 
@CostMultiplierType int  = NULL , 
@AccountCodeID int  = NULL , 
@FamilyID int  = NULL , 
@FamilyStoreID int  = NULL , 
@FamilyClassTypeID int  = NULL , 
@UnitPriceVariableID int  = NULL , 
@UnitPriceVariableStoreID int  = NULL , 
@UnitPriceVariableClassTypeID int  = NULL , 
@PreDiscountFx [nvarchar](MAX)   = NULL , 
@BuiltInDiscountFx [nvarchar](MAX)   = NULL , 
@DefaultDiscountFx [nvarchar](MAX)   = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@FreightFormula [nvarchar](MAX)   = NULL , 
@WarningFx [nvarchar](MAX)   = NULL , 
@ErrorFx [nvarchar](MAX)   = NULL , 
@PreDiscountType int  = NULL , 
@EvaluateOnSaveFormulas [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PricingPlan] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
