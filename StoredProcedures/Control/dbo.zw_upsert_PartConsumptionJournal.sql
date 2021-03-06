/****** Object:  StoredProcedure [dbo].[zw_upsert_PartConsumptionJournal]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_PartConsumptionJournal ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@EmployeeID int  = NULL , 
@PartConsumptionActivityType int  = NULL , 
@PartConsumptionActivityText [nvarchar](25)   = NULL , 
@Description [nvarchar](50)   = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@StartDateTime datetime  = NULL , 
@EndDateTime datetime  = NULL , 
@TotalTime datetime  = NULL , 
@ScheduledDateTime datetime  = NULL , 
@CompletedByID int  = NULL , 
@CompletedDateTime datetime  = NULL , 
@IsSummary bit  = NULL , 
@IsDetail bit  = NULL , 
@SummaryID int  = NULL , 
@SummaryClassTypeID int  = NULL , 
@SummaryAmount [decimal](18,4)  = NULL , 
@DetailAmount [decimal](18,4)  = NULL , 
@StartGLGroupID int  = NULL , 
@EndGLGroupID int  = NULL , 
@AccountID int  = NULL , 
@AccountClassTypeID int  = NULL , 
@ContactID int  = NULL , 
@ContactClassTypeID int  = NULL , 
@TransactionID int  = NULL , 
@TransactionClassTypeID int  = NULL , 
@IsVoided bit  = NULL , 
@VoidedDateTime datetime  = NULL , 
@VoidedEntryID int  = NULL , 
@VoidedEntryClassTypeID int  = NULL , 
@VoidedReason [nvarchar](MAX)   = NULL , 
@QueryStartDateTime datetime  = NULL , 
@QueryEndDateTime datetime  = NULL , 
@ReminderDateTime datetime  = NULL , 
@ReminderPrompt bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PartConsumptionJournal] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[EmployeeID] = @EmployeeID, 
		[PartConsumptionActivityType] = @PartConsumptionActivityType, 
		[PartConsumptionActivityText] = @PartConsumptionActivityText, 
		[Description] = @Description, 
		[Notes] = @Notes, 
		[StartDateTime] = @StartDateTime, 
		[EndDateTime] = @EndDateTime, 
		[TotalTime] = @TotalTime, 
		[ScheduledDateTime] = @ScheduledDateTime, 
		[CompletedByID] = @CompletedByID, 
		[CompletedDateTime] = @CompletedDateTime, 
		[IsSummary] = @IsSummary, 
		[IsDetail] = @IsDetail, 
		[SummaryID] = @SummaryID, 
		[SummaryClassTypeID] = @SummaryClassTypeID, 
		[SummaryAmount] = @SummaryAmount, 
		[DetailAmount] = @DetailAmount, 
		[StartGLGroupID] = @StartGLGroupID, 
		[EndGLGroupID] = @EndGLGroupID, 
		[AccountID] = @AccountID, 
		[AccountClassTypeID] = @AccountClassTypeID, 
		[ContactID] = @ContactID, 
		[ContactClassTypeID] = @ContactClassTypeID, 
		[TransactionID] = @TransactionID, 
		[TransactionClassTypeID] = @TransactionClassTypeID, 
		[IsVoided] = @IsVoided, 
		[VoidedDateTime] = @VoidedDateTime, 
		[VoidedEntryID] = @VoidedEntryID, 
		[VoidedEntryClassTypeID] = @VoidedEntryClassTypeID, 
		[VoidedReason] = @VoidedReason, 
		[QueryStartDateTime] = @QueryStartDateTime, 
		[QueryEndDateTime] = @QueryEndDateTime, 
		[ReminderDateTime] = @ReminderDateTime, 
		[ReminderPrompt] = @ReminderPrompt, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PartConsumptionJournal]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [EmployeeID], [PartConsumptionActivityType], [PartConsumptionActivityText], [Description], [Notes], [StartDateTime], [EndDateTime], [TotalTime], [ScheduledDateTime], [CompletedByID], [CompletedDateTime], [IsSummary], [IsDetail], [SummaryID], [SummaryClassTypeID], [SummaryAmount], [DetailAmount], [StartGLGroupID], [EndGLGroupID], [AccountID], [AccountClassTypeID], [ContactID], [ContactClassTypeID], [TransactionID], [TransactionClassTypeID], [IsVoided], [VoidedDateTime], [VoidedEntryID], [VoidedEntryClassTypeID], [VoidedReason], [QueryStartDateTime], [QueryEndDateTime], [ReminderDateTime], [ReminderPrompt], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @EmployeeID, @PartConsumptionActivityType, @PartConsumptionActivityText, @Description, @Notes, @StartDateTime, @EndDateTime, @TotalTime, @ScheduledDateTime, @CompletedByID, @CompletedDateTime, @IsSummary, @IsDetail, @SummaryID, @SummaryClassTypeID, @SummaryAmount, @DetailAmount, @StartGLGroupID, @EndGLGroupID, @AccountID, @AccountClassTypeID, @ContactID, @ContactClassTypeID, @TransactionID, @TransactionClassTypeID, @IsVoided, @VoidedDateTime, @VoidedEntryID, @VoidedEntryClassTypeID, @VoidedReason, @QueryStartDateTime, @QueryEndDateTime, @ReminderDateTime, @ReminderPrompt, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
