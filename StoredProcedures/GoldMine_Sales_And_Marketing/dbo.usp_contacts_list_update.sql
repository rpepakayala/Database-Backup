/****** Object:  StoredProcedure [dbo].[usp_contacts_list_update]    Script Date: 5/15/2018 12:09:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.usp_contacts_list_update
AS
BEGIN
--DROP TABLE #TempContact

--DECLARE @contactlist TABLE 
--		(Key1		INT, 
--		RECTYPE		VARCHAR(50), 
--		EXT			VARCHAR(50), 
--		[STATUS]	VARCHAR(50), 
--		Contact		VARCHAR(100), 
--		ITLE		VARCHAR(50), 
--		CONTSUPREF	VARCHAR(50),
--		Phone		VARCHAR(50),
--		MERGECODES	VARCHAR(50),
--		ADDRESS1	VARCHAR(50),
--		CITY		VARCHAR(50),
--		STATE		VARCHAR(50),
--		ZIP


Select Distinct
  CONTACT1.KEY1,
  CONTSUPP.RECTYPE,
  CONTSUPP.EXT,
  CONTSUPP.STATUS,
  CONTSUPP.CONTACT,
  CONTSUPP.TITLE,
  CONTSUPP.CONTSUPREF,
  CONTSUPP.PHONE,
  CONTSUPP.MERGECODES,
  CONTSUPP.ADDRESS1,
  CONTSUPP.CITY,
  CONTSUPP.STATE,
  CONTSUPP.ZIP,
  CONTSUPP.COUNTRY,
  CONTSUPP.FAX

From
  CONTSUPP
  Inner Join CONTACT1
    On CONTACT1.ACCOUNTNO = CONTSUPP.ACCOUNTNO
Where
  CONTSUPP.RECTYPE = 'C' And
  CONTSUPP.MERGECODES Like '%H%' And
  CONTACT1.KEY1 <> 'Closed' And
  CONTSUPP.CONTSUPREF = 'Principal'
END
  
--SELECT		*
--FROM		#TempContact


--SELECT		Contact, COUNT(Contact) AS Name
--FROM		#TempContact
--GROUP BY	Contact
--ORDER BY	Name DESC

--SELECT		*
--FROM		#TempContact
--WHERE		Contact = 'David Haroonian'


GO
