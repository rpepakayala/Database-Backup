/****** Object:  View [dbo].[vRecentOrderFact]    Script Date: 5/15/2018 12:13:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vRecentOrderFact]
AS
SELECT	OrderKey
	,	DateKey
	,	StoreKey
	,	CustomerKey
	,	ContactKey
	,	SalesAmt

	FROM dbo.OrderFact

		WHERE DateKey > 20061231


GO
