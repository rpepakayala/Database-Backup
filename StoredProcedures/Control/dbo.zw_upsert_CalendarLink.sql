/****** Object:  StoredProcedure [dbo].[zw_upsert_CalendarLink]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_CalendarLink] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@SortIndex int  = NULL , 
@JournalID int  = NULL , 
@JournalStoreID int  = NULL , 
@JournalClassTypeID int  = NULL , 
@CalendarID int  = NULL , 
@CalendarStoreID int  = NULL , 
@CalendarClassTypeID int  = NULL , 
@RoleName varchar(40)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CalendarLink] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[SortIndex] = @SortIndex, 
		[JournalID] = @JournalID, 
		[JournalStoreID] = @JournalStoreID, 
		[JournalClassTypeID] = @JournalClassTypeID, 
		[CalendarID] = @CalendarID, 
		[CalendarStoreID] = @CalendarStoreID, 
		[CalendarClassTypeID] = @CalendarClassTypeID, 
		[RoleName] = @RoleName, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [CalendarLink]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [SortIndex], [JournalID], [JournalStoreID], [JournalClassTypeID], [CalendarID], [CalendarStoreID], [CalendarClassTypeID], [RoleName], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @SortIndex, @JournalID, @JournalStoreID, @JournalClassTypeID, @CalendarID, @CalendarStoreID, @CalendarClassTypeID, @RoleName, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
