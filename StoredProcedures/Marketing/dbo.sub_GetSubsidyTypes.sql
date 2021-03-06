/****** Object:  StoredProcedure [dbo].[sub_GetSubsidyTypes]    Script Date: 5/15/2018 12:10:27 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_GetSubsidyTypes
(
	@YearSelect int
)
AS
SELECT SubHDesc, SubHID FROM SubsidyHdr
WHERE 
	SubHID NOT IN(
	SELECT D.SubHID
	FROM SubsidyDtl D-- INNER JOIN SubsidyHdr H ON H.SubHID = D.SubHID
	WHERE
		D.SubDCalanderYear = @YearSelect
	)
GROUP BY SubHDesc, SubHID



GO
