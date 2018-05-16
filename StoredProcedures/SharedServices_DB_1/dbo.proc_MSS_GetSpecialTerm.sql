/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSpecialTerm]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSpecialTerm
@ConsumerGpId NVARCHAR(50),
@Term NVARCHAR(100)  AS

SELECT a.SpecialTermId, Term, Definition, Contact, StartDate, EndDate, ReviewDate FROM MSSSpecialTerms a join MSSConsumerGpLink b 
ON a.SpecialTermID = b.SpecialTermId
WHERE ConsumerGpId = @ConsumerGpId and a.Term = @Term


GO
