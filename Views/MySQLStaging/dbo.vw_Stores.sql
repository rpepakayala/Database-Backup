/****** Object:  View [dbo].[vw_Stores]    Script Date: 5/15/2018 12:14:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


/****** Script for SelectTopNRows command from SSMS  ******/

--CREATE  VIEW

CREATE  VIEW [dbo].[vw_Stores] AS 

SELECT  F.franchise_id
      , F.code AS store_number
      , F.franchise_name
      , F.web_number
      , A.address_1
      , ISNULL(A.address_2, '') AS address_2
      , A.city
      , S.NAME AS state_province
      , A.zipcode
      , c.name AS country
      , F.email     
      , (SELECT P.telephone +  ISNULL(P.ext, '')  FROM   dbo.franchises_phone P
        ,dbo.phone_types PT 
		 WHERE P.franchise_id = f.FRANCHISE_ID
		 AND  PT.phone_type_id = P.phone_type_id
		 AND P.primary_phone = 1 AND  PT.NAME = 'work') AS Primary_Phone
	   , (SELECT P.telephone +  ISNULL(P.ext, '')  FROM   dbo.franchises_phone P
       ,dbo.phone_types PT 
		 WHERE P.franchise_id = f.FRANCHISE_ID
		 AND  PT.phone_type_id = P.phone_type_id
		 AND  PT.NAME = 'fax') AS Fax_Phone
      
 
FROM    dbo.franchises F
        INNER JOIN dbo.franchises_address A ON a.franchise_id = f.FRANCHISE_ID
        INNER JOIN countries c ON c.country_id = a.country_id  
        INNER JOIN states s ON  s.country_id = c.country_id  AND S.state_id = a.state_id





GO
