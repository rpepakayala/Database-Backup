/****** Object:  StoredProcedure [dbo].[proc_MSS_GetManagedPropertyAliases]    Script Date: 5/15/2018 12:11:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetManagedPropertyAliases
@LastModified datetime
as
DECLARE @RetVal int  SET @RetVal = 0

Select al.pid, al.alias, mp.LastModified from MSSManagedPropAliases as al
    inner join MSSManagedProperties as mp
    on al.PID = mp.PID
 where mp.LastModified >= @LastModified
SELECT @RetVal = @@ERROR

return @RetVal

GO
