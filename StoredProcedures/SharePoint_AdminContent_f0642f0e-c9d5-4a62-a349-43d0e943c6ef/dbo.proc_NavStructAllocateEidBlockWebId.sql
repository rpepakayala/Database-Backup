/****** Object:  StoredProcedure [dbo].[proc_NavStructAllocateEidBlockWebId]    Script Date: 5/15/2018 12:12:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_NavStructAllocateEidBlockWebId(
    @WebId uniqueidentifier,
    @TempEidCount int,
    @EidMaxNew int,
    @@EidBase int OUTPUT)
AS
    SET NOCOUNT ON
    IF @TempEidCount <= 0 AND @EidMaxNew <= 0
    BEGIN
        SET @@EidBase = 0
        RETURN 0
    END
    BEGIN TRAN
    SELECT
        @@EidBase = NavStructNextEid
    FROM
        Webs WITH (UPDLOCK, ROWLOCK)
    WHERE
        Id = @WebId
    IF @@EidBase IS NULL
    BEGIN
        COMMIT TRAN 
        RETURN 10001
    END
    IF @@EidBase <= @EidMaxNew
        SET @@EidBase = @EidMaxNew + 1
    UPDATE
        Webs
    SET
        NavStructNextEid = @@EidBase + @TempEidCount
    WHERE 
        Id = @WebId
    IF @@RowCount <> 1
    BEGIN
        COMMIT TRAN 
        RETURN 10004
    END
    COMMIT TRAN
    SET @@EidBase = @@EidBase - 1
    RETURN 0

GO
