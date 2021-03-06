/****** Object:  StoredProcedure [dbo].[sub_ListCoOpsWithAnAmountByYear]    Script Date: 5/15/2018 12:10:27 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_ListCoOpsWithAnAmountByYear
(
	@year int
)
 AS
SELECT 
	A.CoOpID, 
	A.CoOpName,
	B.AmountEarned,
	B.AmountAvailable
FROM
	CoOps A
INNER JOIN
	CoOpAmounts B
ON
	A.CoOpID = B.CoOpID
WHERE
	B.Year = @Year 
ORDER BY A.CoOpName



GO
