/****** Object:  StoredProcedure [dbo].[proc_MSS_AddSpecialTerm]    Script Date: 5/15/2018 12:13:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddSpecialTerm
@Term NVARCHAR(100),
@ConsumerGpId NVARCHAR(50),
@StartDate Datetime,
@SpecialTermId INT OUTPUT  AS
SET @SpecialTermId = null
select @SpecialTermId = a.SpecialTermId from MSSSpecialTerms a JOIN MSSConsumerGpLink b
ON a.SpecialTermId = b.SpecialTermID
WHERE a.Term = @Term and b.ConsumerGpId = @ConsumerGpId
IF (@SpecialTermId IS NULL)
BEGIN
    SELECT @SpecialTermId = MAX(SpecialTermId) from MSSSpecialTerms
    IF (@SpecialTermId IS NULL)
    BEGIN
        SET @SpecialTermId = 0
    END
    ELSE
    BEGIN
        SET @SpecialTermId = @specialTermId + 1
    END
    INSERT INTO MSSSpecialTerms VALUES (@SpecialTermId,@Term,null,null,@startDate,CONVERT(DATETIME, '12/31/9999', 101),CONVERT(DATETIME, '12/31/9999', 101))
    INSERT INTO MSSConsumerGpLink VALUES (@SpecialTermId,@ConsumerGpId)
END
ELSE
BEGIN
    RAISERROR('SPECIAL TERM ERROR',16,1)
END
RETURN @specialTermId

GO
