/****** Object:  StoredProcedure [dbo].[proc_DeriveVersioningFlags]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeriveVersioningFlags(
    @Version             int,
    @GetSandbox          bit OUTPUT,
    @GetNonSandBox       bit OUTPUT,
    @RevertOldVersion    bit OUTPUT)
AS
    SET @RevertOldVersion = CASE WHEN @Version < 0 THEN 0 ELSE 1 END
    SET @GetSandbox = CASE
        WHEN @Version = (-2)
        THEN 1
        ELSE 0
        END
    SET @GetNonSandBox = CASE
        WHEN @Version = (-3)
        THEN 1
        ELSE 0
        END

GO
