/****** Object:  StoredProcedure [dbo].[proc_MIP_GetScheduledJobById]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_GetScheduledJobById
(
   @JobId    uniqueidentifier 
) as
   set nocount on

   -- find job
   select
      t.Assembly,
      t.Class,
      t.JobId,
      t.Recurrence,
      t.JobData,
      t.NextDueTime,
      t.Disabled,
      t.DisplayName
   from
      dbo.MIPScheduledJob t
   where
      t.JobId = @JobId

   if (@@error != 0)
      return 1 -- error

   return 0 -- success


GO
