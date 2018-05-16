/****** Object:  StoredProcedure [dbo].[proc_MSS_FetchSDs]    Script Date: 5/15/2018 12:11:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_FetchSDs
       @type INT
as
    select Sdid, Sd from MSSSecurityDescriptors as S, #Temp as T
    where S.Type = @type and S.Sdid = T.Value

    TRUNCATE TABLE #Temp

GO
