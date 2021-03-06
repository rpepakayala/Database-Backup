/****** Object:  StoredProcedure [dbo].[zw_delete_AdvQuery]    Script Date: 5/15/2018 12:09:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_AdvQuery ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@QueryName [nvarchar](75)   = NULL , 
@QueryType int  = NULL , 
@OwnedQuery bit  = NULL , 
@ParentID int  = NULL , 
@ParentStoreID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@Description [nvarchar](MAX)   = NULL , 
@ShowRange int  = NULL , 
@ShowRangeCount int  = NULL , 
@TableNodeID int  = NULL , 
@QuerySortFields [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [AdvQuery] 
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
		AND [QueryName] = @QueryName
		AND [QueryType] = @QueryType
		AND [OwnedQuery] = @OwnedQuery
		AND [ParentID] = @ParentID
		AND [ParentStoreID] = @ParentStoreID
		AND [ParentClassTypeID] = @ParentClassTypeID
		AND [ShowRange] = @ShowRange
		AND [ShowRangeCount] = @ShowRangeCount
		AND [TableNodeID] = @TableNodeID

GO
