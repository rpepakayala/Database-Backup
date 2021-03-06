/****** Object:  StoredProcedure [dbo].[WIPComparison]    Script Date: 5/15/2018 12:09:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[WIPComparison]
( 
@Country varchar(2) = 'US',
@ReportDate datetime = NULL
)
AS
SET NOCOUNT ON

DECLARE @MonthNum int
DECLARE @OrdersMonthLastYear datetime
DECLARE @OrdersMonthThisYear datetime
DECLARE @EndDateLastYear datetime
DECLARE @EndDateThisYear datetime
DECLARE @StoreCount int
DECLARE @OrderCount int
DECLARE @Orders money
DECLARE @TicketAverage money

IF @ReportDate IS NULL
BEGIN
	SET @ReportDate = DATEADD(dd, -1, GETDATE())
END

SET @OrdersMonthThisYear = CAST((CAST(Year(@ReportDate) AS varchar(4)) + '-01-01 00:00:00.000') AS datetime)
SET @OrdersMonthLastYear = DATEADD(yy,-1,@OrdersMonthThisYear)
SET @TicketAverage = 0
SET @MonthNum = 1

CREATE TABLE #WIP (
[Year] int,
[Month] int,
[StoreCount] int,
[OrderCount] int,
[WIP] money,
[TicketAverage] money )

WHILE @MonthNum <= DATEPART(month, @ReportDate) 
BEGIN
	IF @MonthNum = DATEPART(month, @ReportDate)
	BEGIN
		SET @EndDateLastYear = DATEADD(dd, DATEPART(day, @ReportDate), @OrdersMonthLastYear)
		SET @EndDateThisYear = DATEADD(dd, DATEPART(day, @ReportDate), @OrdersMonthThisYear)
	END
	ELSE
	BEGIN
		SET @EndDateLastYear = DATEADD(mm, 1, @OrdersMonthLastYear)
		SET @EndDateThisYear = DATEADD(mm, 1, @OrdersMonthThisYear)
	END

	--Last Year
	SELECT @Orders = SUM(o.SalesSubTotal), @StoreCount = COUNT(DISTINCT(s.StoreKey)), @OrderCount = COUNT(DISTINCT(o.OrderKey)) FROM OrderDim o WITH (NOLOCK)
	JOIN StoreDim s WITH (NOLOCK) ON o.T_WebNumber = s.T_WebNumber
	LEFT JOIN OrderDim o2 ON o.T_WebNumber = o2.T_WebNumber AND o.T_OrderID = o2.T_OrderID AND (o2.Status = 'Voided' OR o2.VoidDate IS NOT NULL)
	WHERE o2.OrderKey IS NULL AND o.VoidDate IS NULL AND s.CountryCode = @Country AND s.Operational <> 'Closed' AND s.StoreOpenDate <= @OrdersMonthLastYear
	AND ((o.PickedUpDate IS NULL AND o.Status IN ('On Hold','Built','WIP')) OR (o.PickedUpDate >= @EndDateLastYear))
	AND s.T_WebNumber > 0 AND s.T_WebNumber NOT IN (849,898,900,901,902,903,904,905,906,907,908,909,981,982,983,984,985,986,987,988,989)
	AND o.OrderDate IS NOT NULL AND o.OrderDate < @EndDateLastYear
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

	IF (@OrderCount > 0)
	BEGIN
		SET @TicketAverage = ROUND((@Orders/@OrderCount), 2)
	END
	ELSE
	BEGIN
		SET @TicketAverage = 0
	END

	INSERT INTO #WIP ([Year], [Month], [StoreCount], [OrderCount], [WIP], [TicketAverage]) VALUES (DATEPART(year, @OrdersMonthLastYear), @MonthNum, @StoreCount, @OrderCount, @Orders, @TicketAverage)
	
	--This Year
	SELECT @Orders = SUM(o.SalesSubTotal), @StoreCount = COUNT(DISTINCT(s.StoreKey)), @OrderCount = COUNT(DISTINCT(o.OrderKey)) FROM OrderDim o WITH (NOLOCK)
	JOIN StoreDim s WITH (NOLOCK) ON o.T_WebNumber = s.T_WebNumber
	LEFT JOIN OrderDim o2 ON o.T_WebNumber = o2.T_WebNumber AND o.T_OrderID = o2.T_OrderID AND (o2.Status = 'Voided' OR o2.VoidDate IS NOT NULL)
	WHERE o2.OrderKey IS NULL AND o.VoidDate IS NULL AND s.CountryCode = @Country AND s.Operational <> 'Closed' AND s.StoreOpenDate <= @OrdersMonthLastYear
	AND ((o.PickedUpDate IS NULL AND o.Status IN ('On Hold','Built','WIP')) OR (o.PickedUpDate >= @EndDateThisYear))
	AND s.T_WebNumber > 0 AND s.T_WebNumber NOT IN (849,898,900,901,902,903,904,905,906,907,908,909,981,982,983,984,985,986,987,988,989)
	AND o.OrderDate IS NOT NULL AND o.OrderDate < @EndDateThisYear
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

	IF (@OrderCount > 0)
	BEGIN
		SET @TicketAverage = ROUND((@Orders/@OrderCount), 2)
	END
	ELSE
	BEGIN
		SET @TicketAverage = 0
	END
	
	INSERT INTO #WIP ([Year], [Month], [StoreCount], [OrderCount], [WIP], [TicketAverage]) VALUES (DATEPART(year, @OrdersMonthThisYear), @MonthNum, @StoreCount, @OrderCount, @Orders, @TicketAverage)

	SET @MonthNum = @MonthNum + 1
	SET @OrdersMonthLastYear = DATEADD(mm, 1, @OrdersMonthLastYear)
	SET @OrdersMonthThisYear = DATEADD(mm, 1, @OrdersMonthThisYear)
END

SELECT [Year], [Month], [StoreCount], [OrderCount], [WIP], [TicketAverage] FROM #WIP
ORDER BY [Year], [Month]

DROP TABLE #WIP

GO
