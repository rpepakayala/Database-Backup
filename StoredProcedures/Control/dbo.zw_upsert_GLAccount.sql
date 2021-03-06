/****** Object:  StoredProcedure [dbo].[zw_upsert_GLAccount]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_GLAccount ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@AccountGroupID int  = NULL , 
@AccountName [nvarchar](25)   = NULL , 
@Description [nvarchar](MAX)   = NULL , 
@ExportAccountName [nvarchar](50)   = NULL , 
@ExportAccountNumber int  = NULL , 
@ExportGroupID int  = NULL , 
@ConsolidateExport bit  = NULL , 
@Depth int  = NULL , 
@PathName1 [nvarchar](150)   = NULL , 
@PathName2 [nvarchar](150)   = NULL , 
@PathName3 [nvarchar](150)   = NULL , 
@PathName4 [nvarchar](150)   = NULL , 
@PathName5 [nvarchar](150)   = NULL , 
@MasterGroup bit  = NULL , 
@AllowSubGroups bit  = NULL , 
@RequireOneMember bit  = NULL , 
@MemberClassTypeID int  = NULL , 
@ConsolidateSubAccounts bit  = NULL , 
@SortIndex float  = NULL , 
@ExportAccountDesc [nvarchar](MAX)   = NULL , 
@NoExportToExternal bit  = NULL , 
@AccountType int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [GLAccount] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[AccountGroupID] = @AccountGroupID, 
		[AccountName] = @AccountName, 
		[Description] = @Description, 
		[ExportAccountName] = @ExportAccountName, 
		[ExportAccountNumber] = @ExportAccountNumber, 
		[ExportGroupID] = @ExportGroupID, 
		[ConsolidateExport] = @ConsolidateExport, 
		[Depth] = @Depth, 
		[PathName1] = @PathName1, 
		[PathName2] = @PathName2, 
		[PathName3] = @PathName3, 
		[PathName4] = @PathName4, 
		[PathName5] = @PathName5, 
		[MasterGroup] = @MasterGroup, 
		[AllowSubGroups] = @AllowSubGroups, 
		[RequireOneMember] = @RequireOneMember, 
		[MemberClassTypeID] = @MemberClassTypeID, 
		[ConsolidateSubAccounts] = @ConsolidateSubAccounts, 
		[SortIndex] = @SortIndex, 
		[ExportAccountDesc] = @ExportAccountDesc, 
		[NoExportToExternal] = @NoExportToExternal, 
		[AccountType] = @AccountType, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [GLAccount]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [AccountGroupID], [AccountName], [Description], [ExportAccountName], [ExportAccountNumber], [ExportGroupID], [ConsolidateExport], [Depth], [PathName1], [PathName2], [PathName3], [PathName4], [PathName5], [MasterGroup], [AllowSubGroups], [RequireOneMember], [MemberClassTypeID], [ConsolidateSubAccounts], [SortIndex], [ExportAccountDesc], [NoExportToExternal], [AccountType], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @AccountGroupID, @AccountName, @Description, @ExportAccountName, @ExportAccountNumber, @ExportGroupID, @ConsolidateExport, @Depth, @PathName1, @PathName2, @PathName3, @PathName4, @PathName5, @MasterGroup, @AllowSubGroups, @RequireOneMember, @MemberClassTypeID, @ConsolidateSubAccounts, @SortIndex, @ExportAccountDesc, @NoExportToExternal, @AccountType, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
