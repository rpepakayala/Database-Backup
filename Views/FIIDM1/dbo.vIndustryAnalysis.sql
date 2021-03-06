/****** Object:  View [dbo].[vIndustryAnalysis]    Script Date: 5/15/2018 12:13:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vIndustryAnalysis]
AS
SELECT TOP 10000 
		I.RawIndustryName
	,	IM.Industry AS IndustryType
	,	CASE WHEN ID1.IndustryKey IS NOT NULL THEN 1 ELSE 0 END AS RawIndustryAccurate
	,	CASE WHEN ID2.IndustryKey IS NOT NULL THEN 1 ELSE 0 END AS IndustryAccurate
	,	IndustryMatch
	,	IndustryMatch1
	,	IndustryMatch2
	,	IndustryMatch3
	
	FROM vRawIndustryDim I
		LEFT JOIN vRawIndustryMappingDim IM ON IM.Industry = I.Industry
		LEFT JOIN CustomerIndustryDim ID1 ON ID1.IndustryName = I.RawIndustryName
		LEFT JOIN CustomerIndustryDim ID2 ON ID2.IndustryName LIKE IM.Industry

		ORDER BY I.Industry, I.RawIndustryname, IndustryMatch, IndustryMatch1, IndustryMatch2, IndustryMatch3

GO
