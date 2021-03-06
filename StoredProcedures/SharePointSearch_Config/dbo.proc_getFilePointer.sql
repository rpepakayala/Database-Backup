/****** Object:  StoredProcedure [dbo].[proc_getFilePointer]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getFilePointer
(
    @ObjectId uniqueidentifier,
    @Pointer binary(16) output
) AS
    SET NOCOUNT ON
    SELECT 
        @Pointer = TEXTPTR(FileImage) 
    FROM 
        Binaries 
    WHERE 
        ObjectId = @ObjectId
    IF (@@ROWCOUNT <> 1)
    BEGIN
        INSERT INTO Binaries
            (ObjectId, FileImage) 
        VALUES
            (@ObjectId, 0x0)
    SELECT 
        @Pointer = TEXTPTR(FileImage) 
    FROM 
        Binaries 
    WHERE 
        ObjectId = @ObjectId
    END

GO
