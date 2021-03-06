/****** Object:  StoredProcedure [dbo].[sub_SubsidyStoreReport]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE sub_SubsidyStoreReport
(
  @year int,
  @webNumber int,
  @subHID int
)
 
AS

SELECT 
	SubHId, 
	SubHDesc, 
	SubLDesc, 
	SubLDate, 
	SubLAmount,
	InvoiceAmount,
	SubLID

FROM 
	SubsidyLog a 
INNER JOIN 
	subsidyHdr b
ON 
	a.SubLHID = b.subHID 
WHERE 
	subLYear =@year
AND 
	SubLStoreID = @webNumber
AND
	SubHId = @subHID

ORDER BY SubLDate
GO
