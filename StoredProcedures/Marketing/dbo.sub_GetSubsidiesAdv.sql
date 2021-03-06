/****** Object:  StoredProcedure [dbo].[sub_GetSubsidiesAdv]    Script Date: 5/15/2018 12:10:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE sub_GetSubsidiesAdv
(
	@YearSelect int,
	@Country int,
	@LocalRadio varchar(10)
)
AS

SELECT 
	H.SubHType, 
	H.SubHDesc, 
	H.SubHID, 
	D.SubDID, 
	D.SubDDesc
FROM 
	SubsidyDtl D 
INNER JOIN 
	SubsidyHdr H 
ON 
	D.SubHID = H.SubHID 
INNER JOIN 
	Contact.dbo.Country C
ON 
	H.SubHMrktCountry = C.CountryMarketingCountry
WHERE 	
 	SubDCalanderYear = @YearSelect  
AND 
	H.SubHMrktCountry = @Country
AND 
	H.CoOpOnly like  '%'+@LocalRadio+'%'
GO
