/****** Object:  StoredProcedure [dbo].[sub_GetSubsidyDetail]    Script Date: 5/15/2018 12:10:27 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON




CREATE PROCEDURE sub_GetSubsidyDetail
(
	@SubLID int
)
AS
SELECT SD.SubDID, SL.SubLYear, SL.SubLID, SL.SubLStoreID, SL.SubLType, SL.SubLHType, SL.SubLDType, dbo.fn_SubsidyDesc(SL.SubLDesc) AS SubsidyDesc, 
	SL.SubLAmount, SL.SubLDate, SL.InvoiceAmount, SL.SubsidyQualifierID, SL.UsageDateFrom, SL.UsageDateTo, C.CountryName, SH.*, SQ.QualifierName, SD.SubDDesc, SD.SubDUptoAmount, SubDAmount
FROM SubsidyLog SL INNER JOIN SubsidyHdr SH 
	ON SH.SubHID = SL.SubLHID INNER JOIN SubsidyDtl SD
		ON SD.SubHID = SH.SubHID INNER JOIN SubsidyQualifiers SQ
			ON SQ.SubDID = SD.SubDID INNER JOIN Contact.dbo.Country C
				ON C.CountryMarketingCountry = SH.SubHMrktCountry
WHERE
	SL.SubLID = @SubLID
GO
