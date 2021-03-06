/****** Object:  StoredProcedure [dbo].[ShoppingCartPlanView]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.ShoppingCartPlanView 
(	
@StoreId int,
@Year int
)
AS
Select Sc.ScId,ScType,MGH.MatGHName,MGH.MatGHSignUpDate,MGH.MatGHType,
	M.MatName,MGD.MatGDMailDate,MGD.MatGDSignUpDate,RMP.RMPHName,
	Month(MGD.MatGDMailDate) As MailDateMonth
	From ShoppingCart Sc
	INNER JOIN MaterialGroupsHdr MGH ON 
		Sc.ScPrdGId = MGH.MatGHId
		AND Sc.ScOrderPrdType = MGH.MatGHType 
	INNER JOIN MaterialGroupsDtl MGD ON 
		(MGH.MatGHId = MGD.MatGHId
		AND Sc.ScPrdId = MGD.MatGPrdId
		AND Sc.ScMailDate = MGD.MatGDMailDate
		AND Sc.ScOrderPrdType = 2)
		OR
		(MGH.MatGHId = MGD.MatGHId
		AND Sc.ScOrderPrdType = 1)
	Left Outer Join RMPHdr RMP ON
		RMP.RMPHId = Sc.ScRMPHId
	Left Outer JOIN Material M ON
		M.MatID = MGD.MatGPrdId
Where ScType = 2 and ScStoreId=@StoreId and Year(MGD.MatGDMailDate)=@Year
Order By MGD.MatGDMailDate


GO
