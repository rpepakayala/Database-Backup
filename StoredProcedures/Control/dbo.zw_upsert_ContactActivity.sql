/****** Object:  StoredProcedure [dbo].[zw_upsert_ContactActivity]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_ContactActivity ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@AllDayEvent bit  = NULL , 
@AutoRollOver bit  = NULL , 
@AutoRun bit  = NULL , 
@Color int  = NULL , 
@ContactActivityType int  = NULL , 
@ContactActivityTypeText [nvarchar](15)   = NULL , 
@ContactCallType int  = NULL , 
@ContactCallTypeText [nvarchar](15)   = NULL , 
@CreatedByID int  = NULL , 
@CreatedDateTime datetime  = NULL , 
@ImageID int  = NULL , 
@IsFromRecurring bit  = NULL , 
@IsTimeless bit  = NULL , 
@Location [nvarchar](50)   = NULL , 
@OriginalScheduledDateTime datetime  = NULL , 
@Priority int  = NULL , 
@PriorityText [nvarchar](15)   = NULL , 
@PrivateEvent bit  = NULL , 
@RecurringActivityID int  = NULL , 
@RunWithoutPrompting bit  = NULL , 
@ScheduledEndDateTime datetime  = NULL , 
@ScheduledStartDateTime datetime  = NULL , 
@Result [nvarchar](MAX)   = NULL , 
@ValidStatus int  = NULL , 
@TransPartID int  = NULL , 
@TransPartStoreID int  = NULL , 
@TransPartClassTypeID int  = NULL , 
@PartInstanceID int  = NULL , 
@IsLocked bit  = NULL , 
@LocationID int  = NULL , 
@LocationStoreID int  = NULL , 
@LocationClassTypeID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [ContactActivity] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[AllDayEvent] = @AllDayEvent, 
		[AutoRollOver] = @AutoRollOver, 
		[AutoRun] = @AutoRun, 
		[Color] = @Color, 
		[ContactActivityType] = @ContactActivityType, 
		[ContactActivityTypeText] = @ContactActivityTypeText, 
		[ContactCallType] = @ContactCallType, 
		[ContactCallTypeText] = @ContactCallTypeText, 
		[CreatedByID] = @CreatedByID, 
		[CreatedDateTime] = @CreatedDateTime, 
		[ImageID] = @ImageID, 
		[IsFromRecurring] = @IsFromRecurring, 
		[IsTimeless] = @IsTimeless, 
		[Location] = @Location, 
		[OriginalScheduledDateTime] = @OriginalScheduledDateTime, 
		[Priority] = @Priority, 
		[PriorityText] = @PriorityText, 
		[PrivateEvent] = @PrivateEvent, 
		[RecurringActivityID] = @RecurringActivityID, 
		[RunWithoutPrompting] = @RunWithoutPrompting, 
		[ScheduledEndDateTime] = @ScheduledEndDateTime, 
		[ScheduledStartDateTime] = @ScheduledStartDateTime, 
		[Result] = @Result, 
		[ValidStatus] = @ValidStatus, 
		[TransPartID] = @TransPartID, 
		[TransPartStoreID] = @TransPartStoreID, 
		[TransPartClassTypeID] = @TransPartClassTypeID, 
		[PartInstanceID] = @PartInstanceID, 
		[IsLocked] = @IsLocked, 
		[LocationID] = @LocationID, 
		[LocationStoreID] = @LocationStoreID, 
		[LocationClassTypeID] = @LocationClassTypeID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [ContactActivity]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [AllDayEvent], [AutoRollOver], [AutoRun], [Color], [ContactActivityType], [ContactActivityTypeText], [ContactCallType], [ContactCallTypeText], [CreatedByID], [CreatedDateTime], [ImageID], [IsFromRecurring], [IsTimeless], [Location], [OriginalScheduledDateTime], [Priority], [PriorityText], [PrivateEvent], [RecurringActivityID], [RunWithoutPrompting], [ScheduledEndDateTime], [ScheduledStartDateTime], [Result], [ValidStatus], [TransPartID], [TransPartStoreID], [TransPartClassTypeID], [PartInstanceID], [IsLocked], [LocationID], [LocationStoreID], [LocationClassTypeID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @AllDayEvent, @AutoRollOver, @AutoRun, @Color, @ContactActivityType, @ContactActivityTypeText, @ContactCallType, @ContactCallTypeText, @CreatedByID, @CreatedDateTime, @ImageID, @IsFromRecurring, @IsTimeless, @Location, @OriginalScheduledDateTime, @Priority, @PriorityText, @PrivateEvent, @RecurringActivityID, @RunWithoutPrompting, @ScheduledEndDateTime, @ScheduledStartDateTime, @Result, @ValidStatus, @TransPartID, @TransPartStoreID, @TransPartClassTypeID, @PartInstanceID, @IsLocked, @LocationID, @LocationStoreID, @LocationClassTypeID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
