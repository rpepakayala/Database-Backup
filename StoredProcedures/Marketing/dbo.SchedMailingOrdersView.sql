/****** Object:  StoredProcedure [dbo].[SchedMailingOrdersView]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.SchedMailingOrdersView
(
	@StoreID int,
	@Year int
)
 AS
Select O.*,OH.OrdHPrdType, OH.OrdHStatus, OH.OrdHSignUpDeadline, MGH.MatGHName, RMP.RMPHName, M.MatName,
	Month(O.OrdDPrdGDMailDate) As MailDateMonth
	From OrderDtl O
	INNER JOIN OrderHdr OH ON
		O.OrdHId = OH.OrdHId
	INNER JOIN MaterialGroupsHdr MGH ON
		O.OrdDPrdGId = MGH.MatGHId
	Left OUTER JOIN RMPHdr RMP ON
		O.OrdDRMPHId = RMPHId
	Left OUTER JOIN Material M ON
		O.OrdDPrdId = M.MatID
Where OH.OrdHStoreId=@StoreID and Year(O.OrdDPrdGDMailDate)=@Year
and (O.OrdDPrdCatType=1 OR O.OrdDPrdCatType=2 OR O.OrdDPrdCatType=3)
and (OH.OrdHStatus <> 6)
Order By O.OrdDPrdGDMailDate


GO
