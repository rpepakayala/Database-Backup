/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSynonyms]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSynonyms
@SpecialTermId INT
AS

SELECT Term from MSSSynonyms where SpecialTermId = @SpecialTermId and Term not in 
(SELECT Term from MSSSpecialTerms where SpecialTermId = @SpecialTermId)

GO
