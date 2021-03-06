/****** Object:  StoredProcedure [dbo].[sub_ListCoOpsByCountryID]    Script Date: 5/15/2018 12:10:27 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_ListCoOpsByCountryID
(
	@CountryID int
)
AS
SELECT 
	A.CoOpID, 
	A.CoOpName, 
	StoreCount =	
		       (
		        SELECT 
				count(*)
		        FROM 
				CoOpStores 
		        WHERE 
				CoOpID = A.CoOpID
		      )
FROM
	 CoOps A
WHERE 
	CountryID = @CountryID
ORDER BY A.CoOpName



GO
