/****** Object:  View [dbo].[HT_Contact1]    Script Date: 5/15/2018 12:13:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE VIEW [dbo].[HT_Contact1]
AS
SELECT DISTINCT 
                      dbo.CONTACT1.ACCOUNTNO, cast(dbo.CONTACT1.KEY1 as int) as 'StoreNum', dbo.CONTACT1.KEY2 as 'FBC', dbo.CONTACT1.KEY3 as 'WebNum', dbo.CONTACT1.KEY3 as 'NAP Status', dbo.CONTACT1.KEY4 as 'Operational', dbo.CONTACT1.KEY5 as 'Compliance', 
                      dbo.CONTACT1.CONTACT as 'Owner', dbo.CONTACT2.UWEBNUMBER as 'WebNumber', dbo.CONTACT1.ADDRESS1, dbo.CONTACT1.ADDRESS2, dbo.CONTACT1.CITY, 
                      dbo.CONTACT1.STATE, dbo.CONTACT1.ZIP, dbo.CONTACT1.COUNTRY, dbo.CONTACT1.PHONE1, dbo.CONTACT1.FAX, dbo.CONTACT2.UEMC as 'EMC', 
                      dbo.CONTACT2.UNAPAGRDT2 as 'NAP Agreement Date', ISNULL(dbo.CONTSUPP.CONTSUPREF, '') + ISNULL(dbo.CONTSUPP.ADDRESS1, '') AS 'EMail', dbo.CONTACT2.UROM
FROM         dbo.CONTACT1 INNER JOIN
                      dbo.CONTACT2 ON dbo.CONTACT1.ACCOUNTNO = dbo.CONTACT2.ACCOUNTNO LEFT OUTER JOIN
                      dbo.CONTSUPP ON dbo.CONTACT1.ACCOUNTNO = dbo.CONTSUPP.ACCOUNTNO AND dbo.CONTSUPP.RECTYPE = 'P' AND 
                      dbo.CONTSUPP.CONTACT = 'E-mail Address' AND SUBSTRING(dbo.CONTSUPP.ZIP, 2, 1) = '1' 
WHERE     (ISNUMERIC(dbo.CONTACT1.KEY1) = 1) AND (LEFT(dbo.CONTACT1.KEY4, 6) <> 'CLOSED') AND (ISNUMERIC(dbo.CONTACT2.UWEBNUMBER) = 1) AND 
                      (UPPER(dbo.CONTACT2.USTORETYPE) NOT IN ('CLOSED')) 








GO
