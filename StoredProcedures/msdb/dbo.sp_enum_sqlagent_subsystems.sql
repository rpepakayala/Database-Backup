/****** Object:  StoredProcedure [dbo].[sp_enum_sqlagent_subsystems]    Script Date: 5/15/2018 12:10:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE sp_enum_sqlagent_subsystems
AS
BEGIN
  DECLARE @retval         INT
  EXEC @retval = msdb.dbo.sp_enum_sqlagent_subsystems_internal
  RETURN(@retval)
END

GO
