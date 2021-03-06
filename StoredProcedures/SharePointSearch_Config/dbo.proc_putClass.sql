/****** Object:  StoredProcedure [dbo].[proc_putClass]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_putClass
(
    @Id uniqueidentifier,
    @BaseClassId uniqueidentifier,
    @FullName nvarchar(256)
) AS
    SET NOCOUNT ON
    BEGIN TRAN
    IF NOT EXISTS (SELECT * FROM Classes WHERE Id = @BaseClassId)
    BEGIN
        IF (@Id <> @BaseClassId) 
        BEGIN
            ROLLBACK TRAN
            RETURN 1 
	END
    END
    IF NOT EXISTS (SELECT * FROM Classes WHERE Id = @Id)
    BEGIN
        INSERT INTO Classes
        (
            Id,
            BaseClassId,
            FullName
        )
        VALUES
        (
            @Id,
            @BaseClassId,
            @FullName
        )
    END
    COMMIT TRAN
    RETURN 0 

GO
