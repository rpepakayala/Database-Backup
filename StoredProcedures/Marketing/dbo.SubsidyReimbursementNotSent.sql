/****** Object:  StoredProcedure [dbo].[SubsidyReimbursementNotSent]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE   PROCEDURE dbo.SubsidyReimbursementNotSent AS
Select OD.OrdHId,OD.OrdDId,SL.SubLId,SL.SubLPrdId, O.OrdHDate,
	SL.SubLAmount,SH.SubHDesc,M.MatName,MG.MatGHName	
	from OrderHdr O
	Inner Join OrderDtl OD
		on O.OrdHId = OD.OrdHId
	Inner Join SubsidyLog SL
		on O.OrdHId = SL.SubLOrdHId
		and OD.OrdDId = SL.SubLOrdDId
	Inner Join SubsidyHdr SH
		on SL.SubLHId = SH.SubHId
	Left Outer Join Material M
		on OD.OrdDPrdId = M.MatId
	Left Outer Join MaterialGroupsHdr MG
		On OD.OrdDPrdGId = MG.MatGHId
	Where OD.OrdDSubsidyReimbursementSent Is NULL
		AND O.OrdHStatus = 7


GO
