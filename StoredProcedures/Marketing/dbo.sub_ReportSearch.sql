/****** Object:  StoredProcedure [dbo].[sub_ReportSearch]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_ReportSearch
(
	@Year int,
	@Country int,
	@CoOpOnly int
)
AS
SELECT SL.*
FROM SubsidyLog SL INNER JOIN SubsidyHdr SH 
	ON SL.SubLHID = SH.SubHID
WHERE
	SL.SubLYear = @Year AND
	SH.SubHMrktCountry = @Country AND
	SH.CoOpOnly = @CoOpOnly



GO
