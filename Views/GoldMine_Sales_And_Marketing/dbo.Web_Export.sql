/****** Object:  View [dbo].[Web_Export]    Script Date: 5/15/2018 12:13:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE VIEW [dbo].[Web_Export]
AS
SELECT CONTACT1.KEY1, CONTACT2.UWEBNUMBER, 
    CONTACT1.ADDRESS1, CONTACT1.ADDRESS2, 
    CONTACT1.CITY, CONTACT1.STATE, CONTACT1.ZIP, 
    CONTACT1.COUNTRY, CONTACT1.PHONE1, CONTACT1.FAX, 
    CONTACT2.UEMC
FROM CONTACT1 INNER JOIN
    CONTACT2 ON 
    CONTACT1.ACCOUNTNO = CONTACT2.ACCOUNTNO
WHERE (CONTACT1.KEY4 <> 'Closed') AND 
    (CONTACT1.KEY1 <> 'Co-Op') AND 
    (CONTACT2.USTORETYPE <> 'Master') AND 
    (CONTACT2.USTORETYPE <> 'Closed') AND 
    (CONTACT2.USTORETYPE <> 'Production')



GO
