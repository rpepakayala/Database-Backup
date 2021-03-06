/****** Object:  StoredProcedure [dbo].[proc_MSS_DeleteSynonym]    Script Date: 5/15/2018 12:11:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeleteSynonym
@SpecialTermId INT,
@Term NVARCHAR(100)
AS

DECLARE @TermId INT

SET @TermId = null

select @TermId = a.SpecialTermId from MSSSpecialTerms a 
WHERE a.Term = @Term and a.SpecialTermId = @SpecialTermId

IF (@TermId IS NULL)
BEGIN
    DELETE MSSSynonyms where @SpecialTermId = SpecialTermId and @Term = Term
END
ELSE
BEGIN
    RAISERROR('SPECIAL TERM ERROR',16,1)
END


GO
