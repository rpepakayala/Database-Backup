/****** Object:  StoredProcedure [dbo].[mdm_GetArtRevisions]    Script Date: 5/15/2018 12:10:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON




CREATE PROCEDURE mdm_GetArtRevisions
AS
SELECT 
	OPS.OrdPSChangeRequest,
	OPS.OrdHId,
	OH.OrdHStoreId,
	OH.OrdHDesc
FROM
	OrderDtlProofSet OPS
INNER JOIN
	OrderHdr OH ON OH.OrdHID = OPS.OrdHID
WHERE
	OPS.OrdPSChangeRequest is not NULL
	OR LEN(OPS.OrdPSChangeRequest) < 1



GO
