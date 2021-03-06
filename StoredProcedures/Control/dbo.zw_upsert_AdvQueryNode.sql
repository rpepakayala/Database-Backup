/****** Object:  StoredProcedure [dbo].[zw_upsert_AdvQueryNode]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_AdvQueryNode ( 
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
 
     INSERT INTO [AdvQueryNode]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [NodeText], [ParentID], [ParentClassTypeID], [ImageIndex], [SortIndex], [NodeTableType], [NodeTableName], [DefinitionDisplayString], [InstanceDisplayString], [Operator], [FieldName], [FieldAggrFunc], [FieldAliasName], [FieldSelectionIndex], [FieldOrderByIndex], [Value1], [Value2], [UseRelativeDate], [InputOption], [BuilderOptions], [SpawnIntoParentCategory], [QueryFieldNameForDisplay], [QueryFieldNameForValue1], [QueryFieldNameForValue2], [VirtualQueryName], [CriteriaType], [CriteriaImageIndex], [GroupID], [ValueFormat], [FieldFormat], [zw_franchise_id], [sys_di], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @NodeText, @ParentID, @ParentClassTypeID, @ImageIndex, @SortIndex, @NodeTableType, @NodeTableName, @DefinitionDisplayString, @InstanceDisplayString, @Operator, @FieldName, @FieldAggrFunc, @FieldAliasName, @FieldSelectionIndex, @FieldOrderByIndex, @Value1, @Value2, @UseRelativeDate, @InputOption, @BuilderOptions, @SpawnIntoParentCategory, @QueryFieldNameForDisplay, @QueryFieldNameForValue1, @QueryFieldNameForValue2, @VirtualQueryName, @CriteriaType, @CriteriaImageIndex, @GroupID, @ValueFormat, @FieldFormat, @zw_franchise_id, getdate(), 1 )

GO
