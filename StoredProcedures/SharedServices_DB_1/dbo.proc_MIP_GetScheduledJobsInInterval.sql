/****** Object:  StoredProcedure [dbo].[proc_MIP_GetScheduledJobsInInterval]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_GetScheduledJobsInInterval
(
   @NextDueTime datetime
) as
   set nocount on
   declare @retval as int

   begin tran

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
   with (updlock, rowlock)
   where
      NextDueTime < @NextDueTime

   if(@@rowcount != 0)
   begin      
      -- set default return value
      set @retval = 0

      delete from 
         MIPScheduledJob
      where
	 Recurrence Is Null and
         NextDueTime < @NextDueTime

      if (@@error != 0)
      begin
         rollback tran
         return 1 -- update error
      end
   end

   commit tran

   return 0 -- success

GO
