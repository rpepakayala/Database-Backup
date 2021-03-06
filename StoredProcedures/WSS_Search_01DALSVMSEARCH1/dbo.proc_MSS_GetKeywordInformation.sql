/****** Object:  StoredProcedure [dbo].[proc_MSS_GetKeywordInformation]    Script Date: 5/15/2018 12:13:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetKeywordInformation
@Term NVARCHAR(100),
@ConsumerGpId NVARCHAR(50),
@Keyword NVARCHAR(100) OUTPUT,
@Definition NVARCHAR(500) OUTPUT AS
DECLARE @SpecialTermId INT 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
SELECT top 1 @SpecialTermId = d.SpecialTermId, @Keyword = b.Term, @Definition = Definition 
FROM MSSSynonyms c, MSSConsumerGpLink d, MSSSpecialTerms b
WHERE d.ConsumerGpId =@ConsumerGpId and c.term = @Term 
and d.SpecialTermId = c.SpecialTermId and b.SpecialTermId = c.SpecialTermId 
and b.EndDate > GetUTCDate() and b.StartDate < GetUTCDate()
SELECT Title, Url, Description FROM MSSBestBets a join MSSBestBetsLink b 
ON a.BestBetId = b.BestBetId
WHERE b.SpecialTermID = @SpecialTermId order by [Order]
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

GO
