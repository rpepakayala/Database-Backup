/****** Object:  StoredProcedure [dbo].[proc_MIP_RemoveScheduledJob]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_RemoveScheduledJob
(
   @JobId uniqueidentifier
) as
   set nocount on

   -- delete job
   delete from
      dbo.MIPScheduledJob
   where
      (JobId = @JobId)

   if (@@error != 0) or (@@rowcount != 1)
      return 1 -- error

   return 0 -- success

GO
