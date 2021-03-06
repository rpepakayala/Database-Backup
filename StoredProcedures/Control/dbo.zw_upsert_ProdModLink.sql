/****** Object:  StoredProcedure [dbo].[zw_upsert_ProdModLink]    Script Date: 5/15/2018 12:09:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_ProdModLink ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ProductID int  = NULL , 
@ModifierID int  = NULL , 
@IsDisplayed int  = NULL , 
@DisplayFormula [nvarchar](MAX)   = NULL , 
@UseDefault int  = NULL , 
@DefaultValue [nvarchar](50)   = NULL , 
@UseAlternateList bit  = NULL , 
@SelectionListID int  = NULL , 
@UseAltList bit  = NULL , 
@AltListParamID int  = NULL , 
@AltListParamStoreID int  = NULL , 
@AltListParamClassTypeID int  = NULL , 
@ShowInGrid bit  = NULL , 
@DefaultPartConsumptionFx [nvarchar](MAX)   = NULL , 
@DefaultPart2ConsumptionFx [nvarchar](MAX)   = NULL , 
@AltDependentListName varchar(40)  = NULL , 
@PartConsumptionFormulas [nvarchar](MAX)   = NULL , 
@PartConsumptionUnitIDs [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [ProdModLink] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ProductID] = @ProductID, 
		[ModifierID] = @ModifierID, 
		[IsDisplayed] = @IsDisplayed, 
		[DisplayFormula] = @DisplayFormula, 
		[UseDefault] = @UseDefault, 
		[DefaultValue] = @DefaultValue, 
		[UseAlternateList] = @UseAlternateList, 
		[SelectionListID] = @SelectionListID, 
		[UseAltList] = @UseAltList, 
		[AltListParamID] = @AltListParamID, 
		[AltListParamStoreID] = @AltListParamStoreID, 
		[AltListParamClassTypeID] = @AltListParamClassTypeID, 
		[ShowInGrid] = @ShowInGrid, 
		[DefaultPartConsumptionFx] = @DefaultPartConsumptionFx, 
		[DefaultPart2ConsumptionFx] = @DefaultPart2ConsumptionFx, 
		[AltDependentListName] = @AltDependentListName, 
		[PartConsumptionFormulas] = @PartConsumptionFormulas, 
		[PartConsumptionUnitIDs] = @PartConsumptionUnitIDs, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [ProdModLink]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ProductID], [ModifierID], [IsDisplayed], [DisplayFormula], [UseDefault], [DefaultValue], [UseAlternateList], [SelectionListID], [UseAltList], [AltListParamID], [AltListParamStoreID], [AltListParamClassTypeID], [ShowInGrid], [DefaultPartConsumptionFx], [DefaultPart2ConsumptionFx], [AltDependentListName], [PartConsumptionFormulas], [PartConsumptionUnitIDs], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ProductID, @ModifierID, @IsDisplayed, @DisplayFormula, @UseDefault, @DefaultValue, @UseAlternateList, @SelectionListID, @UseAltList, @AltListParamID, @AltListParamStoreID, @AltListParamClassTypeID, @ShowInGrid, @DefaultPartConsumptionFx, @DefaultPart2ConsumptionFx, @AltDependentListName, @PartConsumptionFormulas, @PartConsumptionUnitIDs, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
