/****** Object:  StoredProcedure [dbo].[proc_MSS_UpdateBestBet]    Script Date: 5/15/2018 12:13:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_UpdateBestBet
    @ConsumerGpId NVARCHAR(50),
    @BestBetID int,
    @Title NVARCHAR(100),
    @Url NVARCHAR(2048),
    @Description NVARCHAR(500) AS
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
    BEGIN TRANSACTION
    DECLARE @RetVal INT
    SET @RetVal = 0
    DECLARE @bbid INT
    SET @bbid = NULL
    SELECT @bbid = a.BestBetId FROM MSSBestBets a 
        JOIN MSSBBConsumerGpLink b
        ON a.BestBetID = b.BestBetID
        WHERE a.Url = @Url AND b.ConsumerGpId = @ConsumerGpId AND a.BestBetId <> @BestBetID
    IF (@bbid IS NOT NULL)
    BEGIN
        RAISERROR('SPECIAL TERM ERROR', 16, 1)
        GOTO __CLEANUP__
    END 
    Update MSSBestBets
        set 
        Title = @Title,
        Description = @Description,
        Url = @Url
        WHERE BestBetID = @BestBetId
    SELECT @RetVal = @@ERROR
    IF 0 <> @RetVal  
    BEGIN
        GOTO __CLEANUP__
    END
__CLEANUP__:
    IF @RetVal = 0
        COMMIT TRANSACTION
    ELSE
        ROLLBACK TRANSACTION
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    RETURN @RetVal

GO
