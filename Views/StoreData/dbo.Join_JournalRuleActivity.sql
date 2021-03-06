/****** Object:  View [dbo].[Join_JournalRuleActivity]    Script Date: 5/15/2018 12:14:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW Join_JournalRuleActivity AS SELECT J.[ID], J.[StoreID], J.[ClassTypeID], 
       J.[ModifiedByUser], J.[ModifiedByComputer], J.[ModifiedDate], J.[SeqID], J.[IsSystem], J.[IsActive],
       J.[EmployeeID], J.[JournalActivityType], J.[JournalActivityText], J.[Description], J.[Notes],
       J.[StartDateTime], J.[EndDateTime], J.[TotalTime], J.[ScheduledDateTime], J.[CompletedByID], J.[CompletedDateTime],
       J.[IsSummary], J.[IsDetail], J.[SummaryID], J.[SummaryClassTypeID], J.[SummaryAmount], J.[DetailAmount],
       J.[StartGLGroupID], J.[EndGLGroupID], J.[AccountID], J.[AccountClassTypeID], J.[ContactID], J.[ContactClassTypeID],
       J.[TransactionID], J.[TransactionClassTypeID], J.[IsVoided], J.[VoidedDateTime], J.[VoidedEntryID], J.[VoidedEntryClassTypeID],
       J.[VoidedReason], J.[QueryStartDateTime], J.[QueryEndDateTime], J.[ReminderDateTime], J.[ReminderPrompt],
       RA.[AutoRollOver], RA.[AutoRun], RA.[Color], RA.[CreatedByID], RA.[CreatedDateTime], RA.[ImageID],
       RA.[IsFromRecurring], RA.[IsTimeless], RA.[OriginalScheduledDateTime], RA.[Priority], RA.[PriorityText],
       RA.[PrivateEvent], RA.[RecurringActivityID], RA.[RunWithoutPrompting], RA.[ScheduledEndDateTime],
       RA.[ScheduledStartDateTime], RA.[RuleID], RA.[RuleStoreID], RA.[RuleClassTypeID]
FROM [Journal] J
INNER JOIN [RuleActivity] RA ON (J.[ID]=RA.[ID])
                                 AND (J.[ClassTypeID]=RA.[ClassTypeID])

GO
