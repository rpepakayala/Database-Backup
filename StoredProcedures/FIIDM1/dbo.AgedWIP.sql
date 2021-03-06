/****** Object:  StoredProcedure [dbo].[AgedWIP]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[AgedWIP]
( 
@Country varchar(2) = 'US',
@ReportDate datetime = NULL
)
AS
SET NOCOUNT ON

DECLARE @OrdersMonthLastYear datetime
DECLARE @OrdersMonthThisYear datetime
DECLARE @EndDateLastYear datetime
DECLARE @EndDateThisYear datetime
DECLARE @RunDate datetime

IF @ReportDate IS NULL
BEGIN
    SET @RunDate = DATEADD(dd, -1, GETDATE())
END
ELSE
BEGIN
    SET @RunDate = @ReportDate
END

SET @OrdersMonthThisYear = CAST((CAST(Year(@RunDate) AS varchar(4)) + '-' + CAST(Month(@RunDate) AS varchar(2)) + '-01 00:00:00.000') AS datetime)
SET @OrdersMonthLastYear = DATEADD(yy,-1,@OrdersMonthThisYear)
SET @EndDateLastYear = DATEADD(dd, DATEPART(day, @RunDate), @OrdersMonthLastYear)
SET @EndDateThisYear = DATEADD(dd, DATEPART(day, @RunDate), @OrdersMonthThisYear)

SELECT COUNT(DISTINCT(o.OrderKey)) AS AgedWIPCount, SUM(o.SalesSubTotal) AS AgedWIPTotal FROM OrderDim o WITH (NOLOCK)
	JOIN StoreDim s WITH (NOLOCK) ON o.T_WebNumber = s.T_WebNumber
	LEFT JOIN OrderDim o2 ON o.T_WebNumber = o2.T_WebNumber AND o.T_OrderID = o2.T_OrderID AND (o2.Status = 'Voided' OR o2.VoidDate IS NOT NULL)
	WHERE o2.OrderKey IS NULL AND o.VoidDate IS NULL AND s.CountryCode = @Country AND s.Operational <> 'Closed' AND s.StoreOpenDate <= @OrdersMonthLastYear
	AND ((o.PickedUpDate IS NULL AND o.Status IN ('On Hold','Built','WIP')) OR (o.PickedUpDate >= @EndDateThisYear))
	AND s.T_WebNumber > 0 AND s.T_WebNumber NOT IN (849,898,900,901,902,903,904,905,906,907,908,909,981,982,983,984,985,986,987,988,989)
	AND o.OrderDate IS NOT NULL AND o.OrderDate < @EndDateThisYear AND o.OrderDate < DATEADD(yy,-2,@RunDate) 
	AND ((SELECT SUM(od.SalesSubTotal) FROM OrderDim od WITH (NOLOCK)
			JOIN StoreDim store WITH (NOLOCK) ON od.T_WebNumber = store.T_WebNumber
			WHERE store.StoreKey = s.StoreKey AND od.VoidDate IS NULL
			AND ((od.PickedUpDate IS NULL AND od.Status IN ('On Hold','Built','WIP')) OR (od.PickedUpDate >= @EndDateThisYear))
			AND od.OrderDate IS NOT NULL AND od.OrderDate < @EndDateThisYear) > 0)
	AND ((SELECT SUM(od.SalesSubTotal) FROM OrderDim od WITH (NOLOCK)
			JOIN StoreDim store WITH (NOLOCK) ON od.T_WebNumber = store.T_WebNumber
			WHERE store.StoreKey = s.StoreKey AND od.VoidDate IS NULL
			AND ((od.PickedUpDate IS NULL AND od.Status IN ('On Hold','Built','WIP')) OR (od.PickedUpDate >= @EndDateLastYear))
			AND od.OrderDate IS NOT NULL AND od.OrderDate < @EndDateLastYear) > 0)


GO
