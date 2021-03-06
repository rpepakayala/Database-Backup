/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_AllocateClickIds]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_AllocateClickIds
 @numIds int
AS

    IF (@numIds IS NULL) 
        RETURN  

    BEGIN TRANSACTION

    DECLARE @nextId bigint

    SELECT @nextId = nextId FROM MSSQLogNextQueryId WITH (TABLOCKX,HOLDLOCK)

    IF (@nextId IS NULL)
    BEGIN
        INSERT INTO MSSQLogNextQueryId VALUES (@numIds)
        SET @nextId = 0
    END
    ELSE
    BEGIN
        UPDATE MSSQLogNextQueryId SET nextId = (@nextId + @numIds)
    END

    COMMIT TRANSACTION

    SELECT @nextId

GO
