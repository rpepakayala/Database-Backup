/****** Object:  StoredProcedure [dbo].[OrdersComparison_WithTimeZone]    Script Date: 5/15/2018 12:09:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREAte PROCEDURE [dbo].[OrdersComparison_WithTimeZone] /* Not currently used by reporting */
( 
@CountryCode varchar(2) = 'US',
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
DECLARE @TotalOrderCountLastYear INT
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
    SELECT  @Orders = SUM(o.SalesSubtotal)
          , @StoreCount = COUNT(DISTINCT ( s.CenterKey ))
          , @OrderCount = COUNT(DISTINCT ( o.OrderHeaderKey ))

        FROM    Orders.OrderHeaderFact o WITH ( NOLOCK )
		JOIN [FII_ODS].[Orders].[OrderHeaderFactOffSetDates] D ON O.OrderHeaderKey = D.OrderHeaderKey
            INNER JOIN [FII_ODS].Store.StoreFact s WITH ( NOLOCK ) ON o.CenterKey = s.CenterKey
			INNER JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
            INNER JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
    WHERE    c.CountryCode = @CountryCode	
            AND op.OperationalName <> 'Closed'

			AND s.StoreOpenDate <= @OrdersMonthLastYear
            AND d.OrderDate >= @OrdersMonthLastYear
            AND d.OrderDate < @EndDateLastYear

            AND ( ( SELECT  SUM(ol.SalesSubtotal)
                    FROM    Orders.OrderHeaderFact ol WITH ( NOLOCK )
					JOIN [FII_ODS].[Orders].[OrderHeaderFactOffSetDates] Dl ON Ol.OrderHeaderKey = Dl.OrderHeaderKey
                            INNER JOIN Store.StoreFact store WITH ( NOLOCK ) ON ol.CenterKey = store.CenterKey  
                    WHERE   store.CenterKey = s.CenterKey
                            AND dl.OrderDate >= @OrdersMonthThisYear
                            AND dl.OrderDate < @EndDateThisYear
                  ) > 0 )
            AND ( ( SELECT  SUM(ol.SalesSubtotal)
                    FROM    Orders.OrderHeaderFact ol WITH ( NOLOCK )
					JOIN [FII_ODS].[Orders].[OrderHeaderFactOffSetDates] Dl ON Ol.OrderHeaderKey = Dl.OrderHeaderKey
                            INNER JOIN Store.StoreFact store WITH ( NOLOCK ) ON ol.CenterKey = store.CenterKey 
                    WHERE   store.CenterKey = s.CenterKey
                            AND dl.OrderDate >= @OrdersMonthLastYear
                            AND dl.OrderDate < @EndDateLastYear
                  ) > 0 )
            AND ( d.VoidDate IS NULL
                  OR ( d.VoidDate IS NOT NULL
                       AND d.VoidDate >= @VoidDate
                     )
                )
	IF (@OrderCount > 0)
	BEGIN
		SET @TicketAverage = ROUND((@Orders/@OrderCount), 2)
	END
	ELSE
	BEGIN
		SET @TicketAverage = 0
	END

	INSERT INTO #MonthlyOrders ([Year], [Month], [StoreCount], [OrderCount], [Orders], [TicketAverage])
	VALUES (DATEPART(year, @OrdersMonthLastYear), @MonthNum, @StoreCount, @OrderCount, @Orders, @TicketAverage)
	SET @TotalOrderCountLastYear = @TotalOrderCountLastYear + @OrderCount
	SET @TotalOrdersLastYear = @TotalOrdersLastYear + @Orders
	
	--This Year
    SELECT  @Orders = SUM(o.SalesSubtotal)
          , @StoreCount = COUNT(DISTINCT ( s.CenterKey ))
          , @OrderCount = COUNT(DISTINCT ( o.OrderHeaderKey ))
        FROM    Orders.OrderHeaderFact o WITH ( NOLOCK )
		JOIN [FII_ODS].[Orders].[OrderHeaderFactOffSetDates] D ON O.OrderHeaderKey = D.OrderHeaderKey
            INNER JOIN [FII_ODS].Store.StoreFact s WITH ( NOLOCK ) ON o.CenterKey = s.CenterKey
			INNER JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
            INNER JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
    WHERE    c.CountryCode = @CountryCode	
            AND op.OperationalName <> 'Closed'

			AND s.StoreOpenDate <= @OrdersMonthLastYear 
			AND d.OrderDate >= @OrdersMonthThisYear 
			AND d.OrderDate < @EndDateThisYear    
				
				     
	AND ((SELECT SUM(ol.SalesSubtotal) FROM Orders.OrderHeaderFact ol WITH (NOLOCK)
	JOIN [FII_ODS].[Orders].[OrderHeaderFactOffSetDates] Dl ON Ol.OrderHeaderKey = Dl.OrderHeaderKey
			INNER JOIN Store.StoreFact store WITH (NOLOCK) ON ol.CenterKey = store.CenterKey
			WHERE store.CenterKey =s.CenterKey
			AND dl.OrderDate >= @OrdersMonthThisYear AND dl.OrderDate < @EndDateThisYear) > 0)
	AND ((SELECT SUM(ol.SalesSubtotal) FROM Orders.OrderHeaderFact ol WITH (NOLOCK)
	JOIN [FII_ODS].[Orders].[OrderHeaderFactOffSetDates] Dl ON Ol.OrderHeaderKey = Dl.OrderHeaderKey
			INNER JOIN Store.StoreFact store WITH (NOLOCK) ON ol.CenterKey = store.CenterKey
			WHERE store.CenterKey =s.CenterKey
			AND dl.OrderDate >= @OrdersMonthLastYear AND dl.OrderDate < @EndDateLastYear) > 0)
	AND (d.VoidDate IS Null OR (d.voiddate IS NOT NULL AND d.VoidDate >= @VoidDate))

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

SELECT [Year], [Month], [StoreCount], [OrderCount], [Orders], [TicketAverage] FROM #MonthlyOrders WITH (NOLOCK)
ORDER BY [Year], [Month]

DROP TABLE #MonthlyOrders

GO
