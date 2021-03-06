/****** Object:  StoredProcedure [dbo].[sub_ViewCoOp]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE sub_ViewCoOp
(
	@CoOpID int
)
AS
SELECT 
	cps.CoOpID,
	cps.CoOpName,
	cps.CountryID,
	dbo.fn_ConvertToUK(cty.CountryName) as CountryName 
FROM 
	CoOps cps 
INNER JOIN
	Contact.dbo.Country cty
ON
	cps.CountryID = cty.CountryMarketingCountry
WHERE 
	CoOpID = @CoOpID

GO
