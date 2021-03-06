/****** Object:  StoredProcedure [dbo].[sub_CountriesCodesWithSetUpAmountsByYear]    Script Date: 5/15/2018 12:10:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




/*
	FASTSIGNS International Inc. 2004
	CSS 10/6/2004
	This store procedure returns all country code that its subsidies amount
	had been set up by year.
*/
CREATE PROCEDURE sub_CountriesCodesWithSetUpAmountsByYear 
(
	@Year int
)
AS
SET NOCOUNT ON
SELECT DISTINCT 
	A.SubHMrktCountry 
FROM
	 SubsidyHdr A 
INNER JOIN
	SubsidyDtl B
ON
	A.subHID = B.subHID
WHERE
	B.subDCalanderyear = @Year



GO
