/****** Object:  StoredProcedure [dbo].[zw_upsert_RuleActivity]    Script Date: 5/15/2018 12:09:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_RuleActivity ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@AutoRollOver bit  = NULL , 
@AutoRun bit  = NULL , 
@Color int  = NULL , 
@CreatedByID int  = NULL , 
@CreatedDateTime datetime  = NULL , 
@ImageID int  = NULL , 
@IsFromRecurring bit  = NULL , 
@IsTimeless bit  = NULL , 
@OriginalScheduledDateTime datetime  = NULL , 
@Priority int  = NULL , 
@PriorityText [nvarchar](15)   = NULL , 
@PrivateEvent bit  = NULL , 
@RecurringActivityID int  = NULL , 
@RunWithoutPrompting bit  = NULL , 
@ScheduledEndDateTime datetime  = NULL , 
@ScheduledStartDateTime datetime  = NULL , 
@RuleID int  = NULL , 
@RuleStoreID int  = NULL , 
@RuleClassTypeID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [RuleActivity] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[AutoRollOver] = @AutoRollOver, 
		[AutoRun] = @AutoRun, 
		[Color] = @Color, 
		[CreatedByID] = @CreatedByID, 
		[CreatedDateTime] = @CreatedDateTime, 
		[ImageID] = @ImageID, 
		[IsFromRecurring] = @IsFromRecurring, 
		[IsTimeless] = @IsTimeless, 
		[OriginalScheduledDateTime] = @OriginalScheduledDateTime, 
		[Priority] = @Priority, 
		[PriorityText] = @PriorityText, 
		[PrivateEvent] = @PrivateEvent, 
		[RecurringActivityID] = @RecurringActivityID, 
		[RunWithoutPrompting] = @RunWithoutPrompting, 
		[ScheduledEndDateTime] = @ScheduledEndDateTime, 
		[ScheduledStartDateTime] = @ScheduledStartDateTime, 
		[RuleID] = @RuleID, 
		[RuleStoreID] = @RuleStoreID, 
		[RuleClassTypeID] = @RuleClassTypeID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [RuleActivity]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [AutoRollOver], [AutoRun], [Color], [CreatedByID], [CreatedDateTime], [ImageID], [IsFromRecurring], [IsTimeless], [OriginalScheduledDateTime], [Priority], [PriorityText], [PrivateEvent], [RecurringActivityID], [RunWithoutPrompting], [ScheduledEndDateTime], [ScheduledStartDateTime], [RuleID], [RuleStoreID], [RuleClassTypeID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @AutoRollOver, @AutoRun, @Color, @CreatedByID, @CreatedDateTime, @ImageID, @IsFromRecurring, @IsTimeless, @OriginalScheduledDateTime, @Priority, @PriorityText, @PrivateEvent, @RecurringActivityID, @RunWithoutPrompting, @ScheduledEndDateTime, @ScheduledStartDateTime, @RuleID, @RuleStoreID, @RuleClassTypeID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
