/****** Object:  StoredProcedure [dbo].[GetTaskProperties]    Script Date: 5/15/2018 12:10:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[GetTaskProperties]
@ScheduleID uniqueidentifier
AS
-- Grab all of a tasks properties given a task id
select 
        S.[ScheduleID],
        S.[Name],
        S.[StartDate], 
        S.[Flags],
        S.[NextRunTime],
        S.[LastRunTime], 
        S.[EndDate], 
        S.[RecurrenceType],
        S.[MinutesInterval],
        S.[DaysInterval],
        S.[WeeksInterval],
        S.[DaysOfWeek], 
        S.[DaysOfMonth], 
        S.[Month], 
        S.[MonthlyWeek], 
        S.[State], 
        S.[LastRunStatus],
        S.[ScheduledRunTimeout],
        S.[EventType],
        S.[EventData],
        S.[Type],
        S.[Path],
        SUSER_SNAME(Owner.[Sid]),
        Owner.[UserName],
        Owner.[AuthType]
from
    [Schedule] S with (XLOCK) 
    Inner join [Users] Owner on S.[CreatedById] = Owner.UserID
where
    S.[ScheduleID] = @ScheduleID

GO
