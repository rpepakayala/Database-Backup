/****** Object:  StoredProcedure [dbo].[MaterialSubsidiesValidViewGet]    Script Date: 5/15/2018 12:10:17 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.MaterialSubsidiesValidViewGet
(
	@MatId  int = 0,
	@CalendarYear int = 0
)
AS
SELECT shdr.*, ISNULL(ms.SubHId,0) as selSubHId 
FROM SubsidyHdr shdr
LEFT OUTER JOIN MaterialSubsidy ms ON (MatId = @MatID AND ms.SubHId = shdr.SubHId)
WHERE (shdr.SubHType = 1 OR shdr.SubHType = 2) AND shdr.SubHDisable = 'N'
ORDER BY SubHDesc


GO
