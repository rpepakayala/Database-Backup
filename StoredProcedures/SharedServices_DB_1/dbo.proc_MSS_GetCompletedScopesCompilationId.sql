/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCompletedScopesCompilationId]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCompletedScopesCompilationId(
    @CompilationID int OUTPUT )
AS
    SELECT 
        @CompilationID = LastCompilationID
    FROM 
        dbo.MSSScopesSystem

    RETURN @@ERROR

GO
