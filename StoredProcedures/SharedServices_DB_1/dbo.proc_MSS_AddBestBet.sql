/****** Object:  StoredProcedure [dbo].[proc_MSS_AddBestBet]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddBestBet
@Title NVARCHAR(100),
@Url NVARCHAR(2048),
@Description NVARCHAR(500),
@SpecialTermID INT,
@ConsumerGpId NVARCHAR(50),
@Order INT,
@BestBetId INT OUTPUT  AS

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
    BEGIN TRANSACTION

    Update MSSBBLock set LockId = 1

    DECLARE @RetVal int

    SET @BestBetId = null

    select @BestBetId = a.BestBetId from MSSBestBets a JOIN MSSBBConsumerGpLink b
        ON a.BestBetID = b.BestBetID
        WHERE a.Url = @Url and b.ConsumerGpId = @ConsumerGpId

    IF (@BestBetId IS NULL)
    BEGIN
        SELECT @BestBetId = MAX(BestBetId) from MSSBestBets
        IF (@BestBetId IS NULL)
        BEGIN
            SET @BestBetId = 0
        END
        ELSE
        BEGIN
            SET @BestBetId = @BestBetId + 1
        END

        INSERT INTO MSSBestBets VALUES (@BestBetId,@Title,@Url,@Description)
        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  
        BEGIN
            GOTO __CLEANUP__
        END

        EXEC proc_MSS_AddBestBetLink @SpecialTermID, @BestBetId, @order
        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  
        BEGIN
            GOTO __CLEANUP__
        END

        INSERT INTO MSSBBConsumerGpLink VALUES (@BestBetId,@ConsumerGpId)        
        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  
        BEGIN
            GOTO __CLEANUP__
        END

    END
    ELSE
    BEGIN
        RAISERROR('SPECIAL TERM ERROR',16,1)
    END

__CLEANUP__:
    IF @RetVal = 0
        COMMIT TRANSACTION
    ELSE
        ROLLBACK TRANSACTION
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    RETURN @RetVal

GO
