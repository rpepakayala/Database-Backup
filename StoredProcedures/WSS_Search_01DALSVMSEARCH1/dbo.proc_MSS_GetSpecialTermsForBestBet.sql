/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSpecialTermsForBestBet]    Script Date: 5/15/2018 12:13:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSpecialTermsForBestBet
@BestBetId int  AS
SELECT a.SpecialTermId, Term, Definition, Contact, StartDate, EndDate, ReviewDate FROM MSSSpecialTerms a join MSSBestBetsLink b 
ON a.SpecialTermID = b.SpecialTermId
WHERE b.BestBetID  = @BestBetId

GO
