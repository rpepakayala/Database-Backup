/****** Object:  StoredProcedure [dbo].[zw_delete_CustomerGoodsItem]    Script Date: 5/15/2018 12:09:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_CustomerGoodsItem ( 
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
@IsChildByDefault bit  = NULL , 
@EquipmentCostFormula [nvarchar](MAX)   = NULL , 
@LaborCostFormula [nvarchar](MAX)   = NULL , 
@MaterialCostFormula [nvarchar](MAX)   = NULL , 
@ProductionTime int  = NULL , 
@PrintAs [nvarchar](35)   = NULL , 
@Question [nvarchar](50)   = NULL , 
@SortOrder int  = NULL , 
@ImageID int  = NULL , 
@AccountCodeID int  = NULL , 
@DefaultEntryOption int  = NULL , 
@DefaultSelectionListID int  = NULL , 
@IsTaxExempt bit  = NULL , 
@PricingMethodID int  = NULL , 
@DefaultLimitToList bit  = NULL , 
@CustNotes [nvarchar](MAX)   = NULL , 
@DefaultPartConsumptionFx [nvarchar](MAX)   = NULL , 
@DefaultPart2ConsumptionFx [nvarchar](MAX)   = NULL , 
@VarGridParam1ID int  = NULL , 
@VarGridParam2ID int  = NULL , 
@VarGridValues1 [nvarchar](MAX)   = NULL , 
@VarGridValues2 [nvarchar](MAX)   = NULL , 
@IsVarGridEnabled bit  = NULL , 
@SaveTransRecord bit  = NULL , 
@IsChildOnly bit  = NULL , 
@ExcludePromotions bit  = NULL , 
@Flags [nvarchar](MAX)   = NULL , 
@UseCalendar bit  = NULL , 
@UseCalendarForEstimates bit  = NULL , 
@CalendarReqdForOrders bit  = NULL , 
@CalendarReqdForServiceTickets bit  = NULL , 
@CalendarReqdForEstimates bit  = NULL , 
@CalendarRequireTime bit  = NULL , 
@CalendarOffsetDays int  = NULL , 
@UseCalendarTemplate bit  = NULL , 
@CalendarTemplateID int  = NULL , 
@CalendarTemplateStoreID int  = NULL , 
@CalendarTemplateClassTypeID int  = NULL , 
@DefaultStageID int  = NULL , 
@ReCalcTransHeader bit  = NULL , 
@PartConsumptionFormulas [nvarchar](MAX)   = NULL , 
@MaximumSize int  = NULL , 
@InstructorID1 int  = NULL , 
@InstructorID2 int  = NULL , 
@InstructorID3 int  = NULL , 
@StartDate datetime  = NULL , 
@EndDate datetime  = NULL , 
@DefaultCalendarID int  = NULL , 
@DefaultCalendarStoreID int  = NULL , 
@DefaultCalendarClassTypeID int  = NULL , 
@Color int  = NULL , 
@MakeUpType int  = NULL , 
@CanChangeMakeup bit  = NULL , 
@NewEnrollmentOngoing bit  = NULL , 
@ValidPeriodsString [nvarchar](MAX)   = NULL , 
@DefaultStageClassTypeID int  = NULL , 
@PartConsumptionUnitIDs [nvarchar](MAX)   = NULL , 
@FontColor int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CustomerGoodsItem] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
