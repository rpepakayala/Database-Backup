/****** Object:  StoredProcedure [dbo].[zw_upsert_SelectionListItem]    Script Date: 5/15/2018 12:09:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_SelectionListItem ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@SelectionListID int  = NULL , 
@ItemText [nvarchar](40)   = NULL , 
@ListValue [decimal](18,4)  = NULL , 
@CostValue float  = NULL , 
@SortIndex int  = NULL , 
@SecondaryListID int  = NULL , 
@SecondaryListStoreID int  = NULL , 
@SecondaryListClassTypeID int  = NULL , 
@PriceFormula [nvarchar](MAX)   = NULL , 
@CostFormula [nvarchar](MAX)   = NULL , 
@PartID int  = NULL , 
@PartStoreID int  = NULL , 
@PartClassTypeID int  = NULL , 
@PartConsumptionFx [nvarchar](MAX)   = NULL , 
@UseDefaultPart bit  = NULL , 
@ItemProperties [nvarchar](MAX)   = NULL , 
@SecondaryListDefault [nvarchar](40)   = NULL , 
@Part2ID int  = NULL , 
@Part2StoreID int  = NULL , 
@Part2ClassTypeID int  = NULL , 
@Part2ConsumptionFx [nvarchar](MAX)   = NULL , 
@UseDefaultPart2 bit  = NULL , 
@PriceFormulaType int  = NULL , 
@CostFormulaType int  = NULL , 
@ItemColor int  = NULL , 
@PartDescription [nvarchar](MAX)   = NULL , 
@Part2Description [nvarchar](MAX)   = NULL , 
@PartLinksXML [nvarchar](MAX)   = NULL , 
@DependentLinksXML [nvarchar](MAX)   = NULL , 
@ItemFilters [nvarchar](MAX)   = NULL , 
@ItemImageLinks [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [SelectionListItem] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[SelectionListID] = @SelectionListID, 
		[ItemText] = @ItemText, 
		[ListValue] = @ListValue, 
		[CostValue] = @CostValue, 
		[SortIndex] = @SortIndex, 
		[SecondaryListID] = @SecondaryListID, 
		[SecondaryListStoreID] = @SecondaryListStoreID, 
		[SecondaryListClassTypeID] = @SecondaryListClassTypeID, 
		[PriceFormula] = @PriceFormula, 
		[CostFormula] = @CostFormula, 
		[PartID] = @PartID, 
		[PartStoreID] = @PartStoreID, 
		[PartClassTypeID] = @PartClassTypeID, 
		[PartConsumptionFx] = @PartConsumptionFx, 
		[UseDefaultPart] = @UseDefaultPart, 
		[ItemProperties] = @ItemProperties, 
		[SecondaryListDefault] = @SecondaryListDefault, 
		[Part2ID] = @Part2ID, 
		[Part2StoreID] = @Part2StoreID, 
		[Part2ClassTypeID] = @Part2ClassTypeID, 
		[Part2ConsumptionFx] = @Part2ConsumptionFx, 
		[UseDefaultPart2] = @UseDefaultPart2, 
		[PriceFormulaType] = @PriceFormulaType, 
		[CostFormulaType] = @CostFormulaType, 
		[ItemColor] = @ItemColor, 
		[PartDescription] = @PartDescription, 
		[Part2Description] = @Part2Description, 
		[PartLinksXML] = @PartLinksXML, 
		[DependentLinksXML] = @DependentLinksXML, 
		[ItemFilters] = @ItemFilters, 
		[ItemImageLinks] = @ItemImageLinks, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [SelectionListItem]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [SelectionListID], [ItemText], [ListValue], [CostValue], [SortIndex], [SecondaryListID], [SecondaryListStoreID], [SecondaryListClassTypeID], [PriceFormula], [CostFormula], [PartID], [PartStoreID], [PartClassTypeID], [PartConsumptionFx], [UseDefaultPart], [ItemProperties], [SecondaryListDefault], [Part2ID], [Part2StoreID], [Part2ClassTypeID], [Part2ConsumptionFx], [UseDefaultPart2], [PriceFormulaType], [CostFormulaType], [ItemColor], [PartDescription], [Part2Description], [PartLinksXML], [DependentLinksXML], [ItemFilters], [ItemImageLinks], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @SelectionListID, @ItemText, @ListValue, @CostValue, @SortIndex, @SecondaryListID, @SecondaryListStoreID, @SecondaryListClassTypeID, @PriceFormula, @CostFormula, @PartID, @PartStoreID, @PartClassTypeID, @PartConsumptionFx, @UseDefaultPart, @ItemProperties, @SecondaryListDefault, @Part2ID, @Part2StoreID, @Part2ClassTypeID, @Part2ConsumptionFx, @UseDefaultPart2, @PriceFormulaType, @CostFormulaType, @ItemColor, @PartDescription, @Part2Description, @PartLinksXML, @DependentLinksXML, @ItemFilters, @ItemImageLinks, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
