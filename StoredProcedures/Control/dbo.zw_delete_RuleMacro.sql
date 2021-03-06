/****** Object:  StoredProcedure [dbo].[zw_delete_RuleMacro]    Script Date: 5/15/2018 12:09:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_RuleMacro ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@CategoryType int  = NULL , 
@AutoTriggerType int  = NULL , 
@Description [nvarchar](MAX)   = NULL , 
@FilterCondition [nvarchar](MAX)   = NULL , 
@FilterConditionType int  = NULL , 
@FilterType int  = NULL , 
@OwnsQuery bit  = NULL , 
@QueryID int  = NULL , 
@ParentID int  = NULL , 
@ParentStoreID int  = NULL , 
@QueryStoreID int  = NULL , 
@QueryClassTypeID int  = NULL , 
@ProceedCondition [nvarchar](MAX)   = NULL , 
@ProceedConditionType int  = NULL , 
@ProceedType int  = NULL , 
@RuleDataSource int  = NULL , 
@RuleName [nvarchar](35)   = NULL , 
@SecurityRightID int  = NULL , 
@RuleExecuteType int  = NULL , 
@SQLQuery [nvarchar](MAX)   = NULL , 
@IndirectTriggerType int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [RuleMacro] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
