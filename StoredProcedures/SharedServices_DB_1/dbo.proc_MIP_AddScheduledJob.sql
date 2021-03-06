/****** Object:  StoredProcedure [dbo].[proc_MIP_AddScheduledJob]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_AddScheduledJob
(
   @JobId uniqueidentifier,
   @Assembly nvarchar(256),
   @Class nvarchar(256),
   @Recurrence nvarchar(64) = NULL,
   @JobData ntext = NULL,
   @NextDueTime datetime,
   @Disabled bit = 0,
   @DisplayName nvarchar(256) = NULL
) as
   set nocount on

   declare @retval int

   -- set default return value
   set @retval = 0

   -- insert new job
   insert into dbo.MIPScheduledJob
   (
      JobId,
      Assembly,
      Class,
      Recurrence,
      JobData,
      NextDueTime,
      Disabled,
      DisplayName
   )
   values
   (
      @JobId,
      @Assembly,
      @Class,
      @Recurrence,
      @JobData,
      @NextDueTime,
      @Disabled,
      @DisplayName
   )

   if (@@error != 0) or (@@rowcount != 1)
   begin
      return 1 -- insert error
   end

   return @retval -- 0 = success

GO
