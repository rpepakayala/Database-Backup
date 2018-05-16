/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSpecialTermsCountForBestBet]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSpecialTermsCountForBestBet
@BestBetId int,
@Count int OUTPUT AS

SELECT @Count = count(*) FROM MSSSpecialTerms a join MSSBestBetsLink b 
ON a.SpecialTermID = b.SpecialTermId
WHERE b.BestBetID  = @BestBetId


GO
