/****** Object:  View [dbo].[vRecentSalesFact]    Script Date: 5/15/2018 12:13:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vRecentSalesFact]
AS
SELECT	DateKey
	,	StoreKey
	,	CustomerKey
	,	ContactKey
	,	SUM(SalesAmt) AS SalesAmt

	FROM dbo.OrderFact

		WHERE DateKey > 20071231
		GROUP BY DateKey, StoreKey, CustomerKey, ContactKey


GO
