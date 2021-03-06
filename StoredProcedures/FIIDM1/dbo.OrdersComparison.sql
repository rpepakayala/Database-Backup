/****** Object:  StoredProcedure [dbo].[OrdersComparison]    Script Date: 5/15/2018 12:09:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[OrdersComparison]
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
DECLARE @VoidDate datetime
DECLARE @StoreCount int
DECLARE @OrderCount int
DECLARE @Orders money
DECLARE @TotalOrderCountLastYear int
DECLARE @TotalOrderCountThisYear int
DECLARE @TotalOrdersLastYear money
DECLARE @TotalOrdersThisYear money
DECLARE @TicketAverage money

IF @ReportDate IS NULL
BEGIN
	SET @ReportDate = DATEADD(dd, -1, GETDATE())
END

SET @VoidDate = CONVERT(VARCHAR(10),DATEADD(dd, 1, @ReportDate),101)
SET @OrdersMonthThisYear = CAST((CAST(Year(@ReportDate) AS varchar(4)) + '-01-01 00:00:00.000') AS datetime)
SET @OrdersMonthLastYear = DATEADD(yy,-1,@OrdersMonthThisYear)
SET @TotalOrderCountLastYear = 0
SET @TotalOrderCountThisYear = 0
SET @TotalOrdersLastYear = 0
SET @TotalOrdersThisYear = 0
SET @TicketAverage = 0
SET @MonthNum = 1

CREATE TABLE #MonthlyOrders (
[Year] int,
[Month] int,
[StoreCount] int,
[OrderCount] int,
[Orders] money,
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
	SELECT @Orders = SUM(o.SalesAmt), @StoreCount = COUNT(DISTINCT(s.StoreKey)), @OrderCount = COUNT(DISTINCT(o.OrderFactID)) FROM OrderFact o WITH (NOLOCK)
	INNER JOIN StoreDim s WITH (NOLOCK) ON o.StoreKey = s.StoreKey
	INNER JOIN OrderDim od WITH (NOLOCK) ON o.OrderKey = od.OrderKey 
	WHERE s.CountryCode = @Country AND s.Operational <> 'Closed'
	AND s.T_WebNumber > 0 AND s.T_WebNumber NOT IN (849,898,900,901,902,903,904,905,906,907,908,909,981,982,983,984,985,986,987,988,989)
	AND s.StoreOpenDate <= @OrdersMonthLastYear AND o.T_OrderDate >= @OrdersMonthLastYear AND o.T_OrderDate < @EndDateLastYear
	AND ((SELECT SUM(ol.SalesAmt) FROM OrderFact ol WITH (NOLOCK)
			INNER JOIN StoreDim store WITH (NOLOCK) ON ol.StoreKey = store.StoreKey
			WHERE store.StoreKey = s.StoreKey
			AND ol.T_OrderDate >= @OrdersMonthThisYear AND ol.T_OrderDate < @EndDateThisYear) > 0)
	AND ((SELECT SUM(ol.SalesAmt) FROM OrderFact ol WITH (NOLOCK)
			INNER JOIN StoreDim store WITH (NOLOCK) ON ol.StoreKey = store.StoreKey
			WHERE store.StoreKey = s.StoreKey
			AND ol.T_OrderDate >= @OrdersMonthLastYear AND ol.T_OrderDate < @EndDateLastYear) > 0)
	AND (od.VoidDate IS NULL OR (od.voiddate IS NOT NULL AND od.VoidDate >= @VoidDate))

	IF (@OrderCount > 0)
	BEGIN
		SET @TicketAverage = ROUND((@Orders/@OrderCount), 2)
	END
	ELSE
	BEGIN
		SET @TicketAverage = 0
	END

	INSERT INTO #MonthlyOrders ([Year], [Month], [StoreCount], [OrderCount], [Orders], [TicketAverage]) VALUES (DATEPART(year, @OrdersMonthLastYear), @MonthNum, @StoreCount, @OrderCount, @Orders, @TicketAverage)
	SET @TotalOrderCountLastYear = @TotalOrderCountLastYear + @OrderCount
	SET @TotalOrdersLastYear = @TotalOrdersLastYear + @Orders
	
	--This Year
	SELECT @Orders = SUM(o.SalesAmt), @StoreCount = COUNT(DISTINCT(s.StoreKey)), @OrderCount = COUNT(DISTINCT(o.OrderFactID)) FROM OrderFact o WITH (NOLOCK)
	INNER JOIN StoreDim s WITH (NOLOCK) ON o.StoreKey = s.StoreKey
	INNER JOIN OrderDim od WITH (NOLOCK) ON o.OrderKey = od.OrderKey 
	WHERE s.CountryCode = @Country AND s.Operational <> 'Closed'
	AND s.T_WebNumber > 0 AND s.T_WebNumber NOT IN (849,898,900,901,902,903,904,905,906,907,908,909,981,982,983,984,985,986,987,988,989)
	AND s.StoreOpenDate <= @OrdersMonthLastYear AND o.T_OrderDate >= @OrdersMonthThisYear AND o.T_OrderDate < @EndDateThisYear
	AND ((SELECT SUM(ol.SalesAmt) FROM OrderFact ol WITH (NOLOCK)
			INNER JOIN StoreDim store WITH (NOLOCK) ON ol.StoreKey = store.StoreKey
			WHERE store.StoreKey = s.StoreKey
			AND ol.T_OrderDate >= @OrdersMonthThisYear AND ol.T_OrderDate < @EndDateThisYear) > 0)
	AND ((SELECT SUM(ol.SalesAmt) FROM OrderFact ol WITH (NOLOCK)
			INNER JOIN StoreDim store WITH (NOLOCK) ON ol.StoreKey = store.StoreKey
			WHERE store.StoreKey = s.StoreKey
			AND ol.T_OrderDate >= @OrdersMonthLastYear AND ol.T_OrderDate < @EndDateLastYear) > 0)
	AND (od.VoidDate IS Null OR (od.voiddate IS NOT NULL AND od.VoidDate >= @VoidDate))

	IF (@OrderCount > 0)
	BEGIN
		SET @TicketAverage = ROUND((@Orders/@OrderCount), 2)
	END
	ELSE
	BEGIN
		SET @TicketAverage = 0
	END
	
	INSERT INTO #MonthlyOrders ([Year], [Month], [StoreCount], [OrderCount], [Orders], [TicketAverage]) VALUES (DATEPART(year, @OrdersMonthThisYear), @MonthNum, @StoreCount, @OrderCount, @Orders, @TicketAverage)
	SET @TotalOrderCountThisYear = @TotalOrderCountThisYear + @OrderCount
	SET @TotalOrdersThisYear = @TotalOrdersThisYear + @Orders

	SET @MonthNum = @MonthNum + 1
	SET @OrdersMonthLastYear = DATEADD(mm, 1, @OrdersMonthLastYear)
	SET @OrdersMonthThisYear = DATEADD(mm, 1, @OrdersMonthThisYear)
END

IF (@TotalOrderCountLastYear > 0)
BEGIN
	SET @TicketAverage = ROUND((@TotalOrdersLastYear/@TotalOrderCountLastYear), 2)
END
ELSE
BEGIN
	SET @TicketAverage = 0
END

INSERT INTO #MonthlyOrders ([Year], [Month], [OrderCount], [Orders], [TicketAverage]) VALUES (DATEPART(year, DATEADD(yy, -1, @ReportDate)), 13, @TotalOrderCountLastYear, @TotalOrdersLastYear, @TicketAverage)

IF (@TotalOrderCountThisYear > 0)
BEGIN
	SET @TicketAverage = ROUND((@TotalOrdersThisYear/@TotalOrderCountThisYear), 2)
END
ELSE
BEGIN
	SET @TicketAverage = 0
END

INSERT INTO #MonthlyOrders ([Year], [Month], [OrderCount], [Orders], [TicketAverage]) VALUES (DATEPART(year, @ReportDate), 13, @TotalOrderCountThisYear, @TotalOrdersThisYear, @TicketAverage)

SELECT [Year], [Month], [StoreCount], [OrderCount], [Orders], [TicketAverage] FROM #MonthlyOrders
ORDER BY [Year], [Month]

DROP TABLE #MonthlyOrders

GO
