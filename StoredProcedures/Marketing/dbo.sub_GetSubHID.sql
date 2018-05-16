/****** Object:  StoredProcedure [dbo].[sub_GetSubHID]    Script Date: 5/15/2018 12:10:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_GetSubHID
(
	@SubsidyQualifierID int
)
AS
SELECT H.SubHID
FROM SubsidyHdr H INNER JOIN 
	SubsidyDtl D ON H.SubHID = D.SubHID	INNER JOIN 
		SubsidyQualifiers Q ON Q.SubDID = D.SubDID
WHERE
	Q.SubsidyQualifierID = @SubsidyQualifierID



GO
