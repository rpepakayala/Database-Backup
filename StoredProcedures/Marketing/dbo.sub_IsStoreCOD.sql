/****** Object:  StoredProcedure [dbo].[sub_IsStoreCOD]    Script Date: 5/15/2018 12:10:27 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_IsStoreCOD
(
	@WebNumber int,
	@RetVal bit output
)
 AS
SELECT
	 @RetVal = 
		(
			SELECT
				 count(*)
			FROM
				 Contact.dbo.Contact1 
			WHERE 
				uwebnumber = @WebNumber 
			AND 
				(
					key5 LIKE '%cod%' 
				OR 
					key5 LIKE '%ltd%' 
				OR 
					key5 LIKE '%srvcs%'
				) 
		)
-- It will return 1 if store is in COD; otherwise will return 0.
RETURN



GO
