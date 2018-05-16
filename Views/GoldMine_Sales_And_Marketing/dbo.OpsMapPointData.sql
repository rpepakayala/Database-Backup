/****** Object:  View [dbo].[OpsMapPointData]    Script Date: 5/15/2018 12:13:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[OpsMapPointData]
AS
SELECT C1.CONTACT, C1.KEY1, C1.ADDRESS1, C1.CITY, C1.STATE, C1.ZIP, C1.PHONE1, C1.KEY2, C2.UROM, C2.UREGION, C1.KEY3, 
                      C1.KEY4, C1.KEY5
FROM dbo.CONTACT1 C1 
	INNER JOIN dbo.CONTACT2 C2 ON C1.ACCOUNTNO = C2.ACCOUNTNO
WHERE ((C1.KEY5 <> 'closed') OR C1.KEY5 IS NULL) 
	AND (C1.COUNTRY IN ('', 'CANADA') OR C1.COUNTRY IS NULL) 
	AND (C1.KEY1 <> 'Co-Op') 
	AND (C2.ustoreopd > 1/1/1980)





GO
