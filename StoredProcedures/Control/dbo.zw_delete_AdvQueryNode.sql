/****** Object:  StoredProcedure [dbo].[zw_delete_AdvQueryNode]    Script Date: 5/15/2018 12:09:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_AdvQueryNode ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@NodeText [nvarchar](50)   = NULL , 
@ParentID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@ImageIndex int  = NULL , 
@SortIndex int  = NULL , 
@NodeTableType int  = NULL , 
@NodeTableName [nvarchar](50)   = NULL , 
@DefinitionDisplayString [nvarchar](50)   = NULL , 
@InstanceDisplayString [nvarchar](50)   = NULL , 
@Operator int  = NULL , 
@FieldName [nvarchar](50)   = NULL , 
@FieldAggrFunc int  = NULL , 
@FieldAliasName [nvarchar](50)   = NULL , 
@FieldSelectionIndex int  = NULL , 
@FieldOrderByIndex int  = NULL , 
@Value1 [nvarchar](50)   = NULL , 
@Value2 [nvarchar](50)   = NULL , 
@UseRelativeDate bit  = NULL , 
@InputOption int  = NULL , 
@BuilderOptions [nvarchar](50)   = NULL , 
@SpawnIntoParentCategory bit  = NULL , 
@QueryFieldNameForDisplay [nvarchar](50)   = NULL , 
@QueryFieldNameForValue1 [nvarchar](50)   = NULL , 
@QueryFieldNameForValue2 [nvarchar](50)   = NULL , 
@VirtualQueryName [nvarchar](50)   = NULL , 
@CriteriaType int  = NULL , 
@CriteriaImageIndex int  = NULL , 
@GroupID int  = NULL , 
@ValueFormat varchar(25)  = NULL , 
@FieldFormat varchar(25)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [AdvQueryNode] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
		AND [ModifiedByUser] = @ModifiedByUser
		AND [ModifiedByComputer] = @ModifiedByComputer
		AND [ModifiedDate] = @ModifiedDate
		AND [SeqID] = @SeqID
		AND [IsSystem] = @IsSystem
		AND [IsActive] = @IsActive
		AND [NodeText] = @NodeText
		AND [ParentID] = @ParentID
		AND [ParentClassTypeID] = @ParentClassTypeID
		AND [ImageIndex] = @ImageIndex
		AND [SortIndex] = @SortIndex
		AND [NodeTableType] = @NodeTableType
		AND [NodeTableName] = @NodeTableName
		AND [DefinitionDisplayString] = @DefinitionDisplayString
		AND [InstanceDisplayString] = @InstanceDisplayString
		AND [Operator] = @Operator
		AND [FieldName] = @FieldName
		AND [FieldAggrFunc] = @FieldAggrFunc
		AND [FieldAliasName] = @FieldAliasName
		AND [FieldSelectionIndex] = @FieldSelectionIndex
		AND [FieldOrderByIndex] = @FieldOrderByIndex
		AND [Value1] = @Value1
		AND [Value2] = @Value2
		AND [UseRelativeDate] = @UseRelativeDate
		AND [InputOption] = @InputOption
		AND [BuilderOptions] = @BuilderOptions
		AND [SpawnIntoParentCategory] = @SpawnIntoParentCategory
		AND [QueryFieldNameForDisplay] = @QueryFieldNameForDisplay
		AND [QueryFieldNameForValue1] = @QueryFieldNameForValue1
		AND [QueryFieldNameForValue2] = @QueryFieldNameForValue2
		AND [VirtualQueryName] = @VirtualQueryName
		AND [CriteriaType] = @CriteriaType
		AND [CriteriaImageIndex] = @CriteriaImageIndex
		AND [GroupID] = @GroupID
		AND [ValueFormat] = @ValueFormat
		AND [FieldFormat] = @FieldFormat

GO
