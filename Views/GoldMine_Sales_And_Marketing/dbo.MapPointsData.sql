/****** Object:  View [dbo].[MapPointsData]    Script Date: 5/15/2018 12:13:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[MapPointsData]
AS
SELECT CONTACT, KEY1, KEY3, ADDRESS1, CITY, STATE, ZIP, 
    PHONE1,  KEY4, KEY5
FROM CONTACT1
WHERE (KEY5 <> 'closed') AND (COUNTRY = '' OR
    COUNTRY IS NULL) AND (KEY1 <> 'Co-Op')





GO
