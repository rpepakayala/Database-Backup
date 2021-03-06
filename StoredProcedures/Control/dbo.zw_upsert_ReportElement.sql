/****** Object:  StoredProcedure [dbo].[zw_upsert_ReportElement]    Script Date: 5/15/2018 12:09:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_ReportElement ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate smalldatetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ParentID int  = NULL , 
@ParentStoreID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@ElementName [nvarchar](50)   = NULL , 
@Description [nvarchar](50)   = NULL , 
@SortIndex float  = NULL , 
@LinkID int  = NULL , 
@LinkStoreID int  = NULL , 
@LinkClassTypeID int  = NULL , 
@StartDate datetime  = NULL , 
@EndDate datetime  = NULL , 
@ItemPrefix varchar(25)  = NULL , 
@IncomeID int  = NULL , 
@IncomeStoreID int  = NULL , 
@IncomeClassTypeID int  = NULL , 
@FamilyID int  = NULL , 
@FamilyStoreID int  = NULL , 
@FamilyClassTypeID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
     INSERT INTO [ReportElement]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ParentID], [ParentStoreID], [ParentClassTypeID], [ElementName], [Description], [SortIndex], [LinkID], [LinkStoreID], [LinkClassTypeID], [StartDate], [EndDate], [ItemPrefix], [IncomeID], [IncomeStoreID], [IncomeClassTypeID], [FamilyID], [FamilyStoreID], [FamilyClassTypeID], [zw_franchise_id], [sys_di], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ParentID, @ParentStoreID, @ParentClassTypeID, @ElementName, @Description, @SortIndex, @LinkID, @LinkStoreID, @LinkClassTypeID, @StartDate, @EndDate, @ItemPrefix, @IncomeID, @IncomeStoreID, @IncomeClassTypeID, @FamilyID, @FamilyStoreID, @FamilyClassTypeID, @zw_franchise_id, getdate(), 1 )

GO
