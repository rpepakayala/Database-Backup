/****** Object:  StoredProcedure [dbo].[zw_upsert_UserFieldDef]    Script Date: 5/15/2018 12:09:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_UserFieldDef ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@FieldName [nvarchar](50)   = NULL , 
@Description [nvarchar](50)   = NULL , 
@DataType int  = NULL , 
@AssociatedClassTypeID int  = NULL , 
@FieldIndex int  = NULL , 
@AnswerRequired bit  = NULL , 
@Alignment int  = NULL , 
@DisplayFormatString [nvarchar](25)   = NULL , 
@SortIndex int  = NULL , 
@UseDropdownBox bit  = NULL , 
@DropdownValues [nvarchar](MAX)   = NULL , 
@LimitToList bit  = NULL , 
@CategoryName varchar(40)  = NULL , 
@UseDefaultColors bit  = NULL , 
@DescriptionColor int  = NULL , 
@AnswerColor int  = NULL , 
@DescriptionFontColor int  = NULL , 
@AnswerFontColor int  = NULL , 
@AnswerRequiredOrd bit  = NULL , 
@AnswerRequiredEst bit  = NULL , 
@AnswerRequiredTemp bit  = NULL , 
@AnswerRequiredST bit  = NULL , 
@ShowOrder bit  = NULL , 
@ShowEstimate bit  = NULL , 
@ShowTemplate bit  = NULL , 
@ShowService bit  = NULL , 
@ShowClient bit  = NULL , 
@ShowProspect bit  = NULL , 
@ClearOnClone bit  = NULL , 
@ClearOnConvert bit  = NULL , 
@ShowFullContact bit  = NULL , 
@ShowLimitedContact bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [UserFieldDef] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[FieldName] = @FieldName, 
		[Description] = @Description, 
		[DataType] = @DataType, 
		[AssociatedClassTypeID] = @AssociatedClassTypeID, 
		[FieldIndex] = @FieldIndex, 
		[AnswerRequired] = @AnswerRequired, 
		[Alignment] = @Alignment, 
		[DisplayFormatString] = @DisplayFormatString, 
		[SortIndex] = @SortIndex, 
		[UseDropdownBox] = @UseDropdownBox, 
		[DropdownValues] = @DropdownValues, 
		[LimitToList] = @LimitToList, 
		[CategoryName] = @CategoryName, 
		[UseDefaultColors] = @UseDefaultColors, 
		[DescriptionColor] = @DescriptionColor, 
		[AnswerColor] = @AnswerColor, 
		[DescriptionFontColor] = @DescriptionFontColor, 
		[AnswerFontColor] = @AnswerFontColor, 
		[AnswerRequiredOrd] = @AnswerRequiredOrd, 
		[AnswerRequiredEst] = @AnswerRequiredEst, 
		[AnswerRequiredTemp] = @AnswerRequiredTemp, 
		[AnswerRequiredST] = @AnswerRequiredST, 
		[ShowOrder] = @ShowOrder, 
		[ShowEstimate] = @ShowEstimate, 
		[ShowTemplate] = @ShowTemplate, 
		[ShowService] = @ShowService, 
		[ShowClient] = @ShowClient, 
		[ShowProspect] = @ShowProspect, 
		[ClearOnClone] = @ClearOnClone, 
		[ClearOnConvert] = @ClearOnConvert, 
		[ShowFullContact] = @ShowFullContact, 
		[ShowLimitedContact] = @ShowLimitedContact, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [UserFieldDef]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [FieldName], [Description], [DataType], [AssociatedClassTypeID], [FieldIndex], [AnswerRequired], [Alignment], [DisplayFormatString], [SortIndex], [UseDropdownBox], [DropdownValues], [LimitToList], [CategoryName], [UseDefaultColors], [DescriptionColor], [AnswerColor], [DescriptionFontColor], [AnswerFontColor], [AnswerRequiredOrd], [AnswerRequiredEst], [AnswerRequiredTemp], [AnswerRequiredST], [ShowOrder], [ShowEstimate], [ShowTemplate], [ShowService], [ShowClient], [ShowProspect], [ClearOnClone], [ClearOnConvert], [ShowFullContact], [ShowLimitedContact], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @FieldName, @Description, @DataType, @AssociatedClassTypeID, @FieldIndex, @AnswerRequired, @Alignment, @DisplayFormatString, @SortIndex, @UseDropdownBox, @DropdownValues, @LimitToList, @CategoryName, @UseDefaultColors, @DescriptionColor, @AnswerColor, @DescriptionFontColor, @AnswerFontColor, @AnswerRequiredOrd, @AnswerRequiredEst, @AnswerRequiredTemp, @AnswerRequiredST, @ShowOrder, @ShowEstimate, @ShowTemplate, @ShowService, @ShowClient, @ShowProspect, @ClearOnClone, @ClearOnConvert, @ShowFullContact, @ShowLimitedContact, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
