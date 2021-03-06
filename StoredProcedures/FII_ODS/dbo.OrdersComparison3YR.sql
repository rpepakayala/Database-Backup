/****** Object:  StoredProcedure [dbo].[OrdersComparison3YR]    Script Date: 5/15/2018 12:09:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE PROCEDURE [dbo].[OrdersComparison3YR] /* used by orders placed report */
    (
      @CountryCode VARCHAR(2) = 'US' ,
      @ReportDate DATETIME = NULL
    )
AS
    SET NOCOUNT ON

/************ testing ************/
--DECLARE @CountryCode VARCHAR(2) 
--DECLARE @ReportDate DATETIME
--SET @CountryCode = 'us'
--SET @ReportDate = NULL
/*********************************/

    DECLARE @MonthNum INT
    DECLARE @OrdersMonthLastYear DATETIME
    DECLARE @OrdersMonthThisYear DATETIME
    DECLARE @EndDateLastYear DATETIME
    DECLARE @EndDateThisYear DATETIME
    DECLARE @VoidDate DATETIME
    DECLARE @StoreCount INT
    DECLARE @OrderCount INT
    DECLARE @Orders DECIMAL(19, 6)
    DECLARE @TotalOrderCountLastYear INT
    DECLARE @TotalOrderCountThisYear INT
    DECLARE @TotalOrdersLastYear DECIMAL(19, 6)
    DECLARE @TotalOrdersThisYear DECIMAL(19, 6)
    DECLARE @TicketAverage DECIMAL(19, 6)


/**************/

    DECLARE @AvgOrdersDifference DECIMAL(19, 6)
    DECLARE @TotalOrdersDifference DECIMAL(19, 6)

    DECLARE @OrdersDiffPercentage DECIMAL(19, 6)
    DECLARE @TotalAVGBusinessDayOrdersDiffPercentage DECIMAL(19, 6)

    DECLARE @AVGBusinessDayOrdersLastYear DECIMAL(19, 6)
    DECLARE @AVGBusinessDayOrdersThisYear DECIMAL(19, 6)
    DECLARE @TotalBusinessDayOrdersLastYearAVG DECIMAL(19, 6)
    DECLARE @TotalBusinessDayOrdersThisYearAVG DECIMAL(19, 6)
    DECLARE @TotalAVGBusinessDayOrdersDiff DECIMAL(19, 6)

    DECLARE @WorkdaysThisYear INT
    DECLARE @WorkdaysLastYear INT
    DECLARE @TotalWorkdaysThisYear INT
    DECLARE @TotalWorkdaysLastYear INT


    SET @TotalOrdersDifference = 0.000000
    SET @AvgOrdersDifference = 0.000000


    SET @TotalBusinessDayOrdersLastYearAVG = 0.000000
    SET @TotalBusinessDayOrdersThisYearAVG = 0.000000
/***************************************/



    IF @ReportDate IS NULL
        BEGIN
            SET @ReportDate = DATEADD(dd, -1, GETDATE())
        END

    SET @VoidDate = CONVERT(VARCHAR(10), DATEADD(dd, 1, @ReportDate), 101)
    SET @OrdersMonthThisYear = CAST(( CAST(YEAR(@ReportDate) AS VARCHAR(4))
                                      + '-01-01 00:00:00.000' ) AS DATETIME)
    SET @OrdersMonthLastYear = DATEADD(yy, -1, @OrdersMonthThisYear)
    SET @TotalOrderCountLastYear = 0
    SET @TotalOrderCountThisYear = 0
    SET @TotalOrdersLastYear = 0.000000
    SET @TotalOrdersThisYear = 0.000000
    SET @TicketAverage = 0.000000
    SET @TotalWorkdaysThisYear = 0
    SET @TotalWorkdaysLastYear = 0
    SET @MonthNum = 1



    CREATE TABLE #MonthlyOrders
        (
          [Year] INT ,
          [Month] INT ,
          [StoreCount] INT ,
          [OrderCount] INT ,
          [Orders] DECIMAL(19, 6) ,
          [TicketAverage] DECIMAL(19, 6) ,
          [BusinessDays] INT ,
          [AVGBusinessDayOrders] DECIMAL(19, 6) ,
          [AVGBusinessDayOrdersDiff] DECIMAL(19, 6) ,
          [OrdersDiffPercentage] DECIMAL(19, 6)
        )
	


    WHILE @MonthNum <= DATEPART(MONTH, @ReportDate)
        BEGIN
            IF @MonthNum = DATEPART(MONTH, @ReportDate)
                BEGIN
                    SET @EndDateLastYear = DATEADD(dd,
                                                   DATEPART(DAY, @ReportDate),
                                                   @OrdersMonthLastYear)
                    SET @EndDateThisYear = DATEADD(dd,
                                                   DATEPART(DAY, @ReportDate),
                                                   @OrdersMonthThisYear)
                    SET @WorkdaysLastYear = ( SELECT
                                                COUNT(*)
                                              FROM
                                                [FII_ODS].[System].[Calendar]
                                              WHERE
                                                IsWorkDay = 1
                                                AND dt >= @OrdersMonthLastYear
                                                AND dt < @EndDateLastYear
                                            )
                    SET @WorkdaysThisYear = ( SELECT
                                                COUNT(*)
                                              FROM
                                                [FII_ODS].[System].[Calendar]
                                              WHERE
                                                IsWorkDay = 1
                                                AND dt >= @OrdersMonthThisYear
                                                AND dt < @EndDateThisYear
                                            )
                    SET @WorkdaysLastYear = CASE WHEN @WorkdaysLastYear = 0
                                                 THEN 1
                                                 ELSE @WorkdaysLastYear
                                            END
                    SET @WorkdaysThisYear = CASE WHEN @WorkdaysThisYear = 0
                                                 THEN 1
                                                 ELSE @WorkdaysThisYear
                                            END

--PRINT '@MonthNum' 
--PRINT @MonthNum
--PRINT '@EndDateLastYear'  
--PRINT @EndDateLastYear
--PRINT '@EndDateThisYear'  
--PRINT @EndDateThisYear
--PRINT '@WorkdaysLastYear'  
--PRINT @WorkdaysLastYear
--PRINT '@WorkdaysThisYear'  
--PRINT @WorkdaysThisYear


                END
            ELSE
                BEGIN
                    SET @EndDateLastYear = DATEADD(mm, 1, @OrdersMonthLastYear)
                    SET @EndDateThisYear = DATEADD(mm, 1, @OrdersMonthThisYear)

                    SET @WorkdaysLastYear = ( SELECT
                                                COUNT(*)
                                              FROM
                                                [FII_ODS].[System].[Calendar]
                                              WHERE
                                                IsWorkDay = 1
                                                AND dt >= @OrdersMonthLastYear
                                                AND dt < @EndDateLastYear
                                            )
                    SET @WorkdaysThisYear = ( SELECT
                                                COUNT(*)
                                              FROM
                                                [FII_ODS].[System].[Calendar]
                                              WHERE
                                                IsWorkDay = 1
                                                AND dt >= @OrdersMonthThisYear
                                                AND dt < @EndDateThisYear
                                            )

--PRINT '@MonthNum' 
--PRINT @MonthNum
--PRINT '@EndDateLastYear'  
--PRINT @EndDateLastYear
--PRINT '@EndDateThisYear'  
--PRINT @EndDateThisYear
--PRINT '@WorkdaysLastYear'  
--PRINT @WorkdaysLastYear
--PRINT '@WorkdaysThisYear'  
--PRINT @WorkdaysThisYear

                END



	--Last Year
            SELECT
                @Orders = SUM(o.SalesSubtotal) ,
                @StoreCount = COUNT(DISTINCT ( s.CenterKey )) ,
                @OrderCount = COUNT(DISTINCT ( o.OrderHeaderKey )) ,
                @AVGBusinessDayOrdersLastYear = ( SUM(o.SalesSubtotal) )
                / @WorkdaysLastYear
            FROM
                Orders.OrderHeaderFact o WITH ( NOLOCK )
                INNER JOIN vw_Store s WITH ( NOLOCK ) ON o.CenterKey = s.CenterKey
            WHERE
                S.CountryCode = @CountryCode
                AND s.StoreTypeName = 'Center'
--              AND op.OperationalName <> 'Closed'
--                AND s.StoreOpenDate <= @OrdersMonthLastYear
                AND o.OrderDate >= @OrdersMonthLastYear
                AND o.OrderDate < @EndDateLastYear
                --AND ( ( SELECT
                --            SUM(ol.SalesSubtotal)
                --        FROM
                --            Orders.OrderHeaderFact ol WITH ( NOLOCK )
                --            INNER JOIN Store.StoreFact store WITH ( NOLOCK ) ON ol.CenterKey = store.CenterKey AND store.CenterKey = s.CenterKey
                --        WHERE
                --            store.CenterKey = s.CenterKey
                --            AND ol.OrderDate >= @OrdersMonthThisYear
                --            AND ol.OrderDate < @EndDateThisYear
                --      ) > 0 )
                --AND ( ( SELECT
                --            SUM(ol.SalesSubtotal)
                --        FROM
                --            Orders.OrderHeaderFact ol WITH ( NOLOCK )
                --            INNER JOIN Store.StoreFact store WITH ( NOLOCK ) ON ol.CenterKey = store.CenterKey AND store.CenterKey = s.CenterKey
                --        WHERE
                --            store.CenterKey = s.CenterKey
                --            AND ol.OrderDate >= @OrdersMonthLastYear
                --            AND ol.OrderDate < @EndDateLastYear
                --      ) > 0 )
                --AND ( o.VoidDate IS NULL
                --      OR ( o.VoidDate IS NOT NULL
                --           AND o.VoidDate >= @VoidDate
                --         )
                --    )
            IF ( @OrderCount > 0 )
                BEGIN
                    SET @TicketAverage = ROUND(( @Orders / @OrderCount ), 2)
                END
            ELSE
                BEGIN
                    SET @TicketAverage = 0.000000
                END

            SET @AvgOrdersDifference = 0.000000 
            SET @OrdersDiffPercentage = 0.000000 							



            INSERT  INTO #MonthlyOrders
                    ( [Year] ,
                      [Month] ,
                      [StoreCount] ,
                      [OrderCount] ,
                      [Orders] ,
                      [TicketAverage] ,
                      [BusinessDays] ,
                      [AVGBusinessDayOrders] ,
                      [AVGBusinessDayOrdersDiff] ,
                      [OrdersDiffPercentage] 
                    )
            VALUES
                    ( DATEPART(YEAR, @OrdersMonthLastYear) ,
                      @MonthNum ,
                      @StoreCount ,
                      @OrderCount ,
                      @Orders ,
                      @TicketAverage ,
                      @WorkdaysLastYear ,
                      @AVGBusinessDayOrdersLastYear ,
                      @AvgOrdersDifference ,
                      @OrdersDiffPercentage
                    )
            SET @TotalOrderCountLastYear = @TotalOrderCountLastYear
                + @OrderCount
            SET @TotalOrdersLastYear = @TotalOrdersLastYear + @Orders
            SET @TotalWorkdaysLastYear = @TotalWorkdaysLastYear
                + @WorkdaysLastYear
            SET @TotalBusinessDayOrdersLastYearAVG = @TotalBusinessDayOrdersLastYearAVG
                + @AVGBusinessDayOrdersLastYear
	
	--This Year
            SELECT
                @Orders = SUM(o.SalesSubtotal) ,
                @StoreCount = COUNT(DISTINCT ( s.CenterKey )) ,
                @OrderCount = COUNT(DISTINCT ( o.OrderHeaderKey )) ,
                @AVGBusinessDayOrdersThisYear = ( SUM(o.SalesSubtotal) )
                / @WorkdaysThisYear
            FROM
                Orders.OrderHeaderFact o WITH ( NOLOCK )
                INNER JOIN vw_Store s WITH ( NOLOCK ) ON o.CenterKey = s.CenterKey
            WHERE
                s.CountryCode = @CountryCode
                AND s.StoreTypeName = 'Center'
--                AND op.OperationalName <> 'Closed'
--                AND s.StoreOpenDate <= @OrdersMonthLastYear
                AND o.OrderDate >= @OrdersMonthThisYear
                AND o.OrderDate < @EndDateThisYear
                --AND ( ( SELECT
                --            SUM(ol.SalesSubtotal)
                --        FROM
                --            Orders.OrderHeaderFact ol WITH ( NOLOCK )
                --            INNER JOIN Store.StoreFact store WITH ( NOLOCK ) ON ol.CenterKey = store.CenterKey AND store.CenterKey = s.CenterKey
                --        WHERE
                --            store.CenterKey = s.CenterKey
                --            AND ol.OrderDate >= @OrdersMonthThisYear
                --            AND ol.OrderDate < @EndDateThisYear
                --      ) > 0 )
                --AND ( ( SELECT
                --            SUM(ol.SalesSubtotal)
                --        FROM
                --            Orders.OrderHeaderFact ol WITH ( NOLOCK )
                --            INNER JOIN Store.StoreFact store WITH ( NOLOCK ) ON ol.CenterKey = store.CenterKey AND store.CenterKey = s.CenterKey
                --        WHERE
                --            store.CenterKey = s.CenterKey
                --            AND ol.OrderDate >= @OrdersMonthLastYear
                --            AND ol.OrderDate < @EndDateLastYear
                --      ) > 0 )
                --AND ( o.VoidDate IS NULL
                --      OR ( o.voiddate IS NOT NULL
                --           AND o.VoidDate >= @VoidDate
                --         )
                --    )

            IF ( @OrderCount > 0 )
                BEGIN
                    SET @TicketAverage = ROUND(( @Orders / @OrderCount ), 2)
                END
            ELSE
                BEGIN
                    SET @TicketAverage = 0.000000
                END

            SET @AvgOrdersDifference = @AVGBusinessDayOrdersThisYear
                - @AVGBusinessDayOrdersLastYear
		
            /*SET @OrdersDiffPercentage = @AvgOrdersDifference
                / @AVGBusinessDayOrdersThisYear		10/27/2014 - per R.Herbert */			

            SET @OrdersDiffPercentage = @AvgOrdersDifference
                / @AVGBusinessDayOrdersLastYear	

	
            INSERT  INTO #MonthlyOrders
                    ( [Year] ,
                      [Month] ,
                      [StoreCount] ,
                      [OrderCount] ,
                      [Orders] ,
                      [TicketAverage] ,
                      [BusinessDays] ,
                      [AVGBusinessDayOrders] ,
                      [AVGBusinessDayOrdersDiff] ,
                      [OrdersDiffPercentage] 
                    )
            VALUES
                    ( DATEPART(YEAR, @OrdersMonthThisYear) ,
                      @MonthNum ,
                      @StoreCount ,
                      @OrderCount ,
                      @Orders ,
                      @TicketAverage ,
                      @WorkdaysThisYear ,
                      @AVGBusinessDayOrdersThisYear ,
                      @AvgOrdersDifference ,
                      @OrdersDiffPercentage
                    )
            SET @TotalOrderCountThisYear = @TotalOrderCountThisYear
                + @OrderCount
            SET @TotalOrdersThisYear = @TotalOrdersThisYear + @Orders

            SET @TotalWorkdaysThisYear = @TotalWorkdaysThisYear
                + @WorkdaysThisYear
            
            SET @TotalBusinessDayOrdersThisYearAVG = @TotalBusinessDayOrdersThisYearAVG
                + @AVGBusinessDayOrdersThisYear
            SET @MonthNum = @MonthNum + 1
            SET @OrdersMonthLastYear = DATEADD(mm, 1, @OrdersMonthLastYear)
            SET @OrdersMonthThisYear = DATEADD(mm, 1, @OrdersMonthThisYear)
        END

    IF ( @TotalOrderCountLastYear > 0 )
        BEGIN
            SET @TicketAverage = ROUND(( @TotalOrdersLastYear
                                         / @TotalOrderCountLastYear ), 2)
        END
    ELSE
        BEGIN
            SET @TicketAverage = 0.000000
        END
    
    
    SET @TotalBusinessDayOrdersLastYearAVG = @TotalOrdersLastYear
        / @TotalWorkdaysLastYear
    
    SET @TotalBusinessDayOrdersThisYearAVG = @TotalOrdersThisYear
        / @TotalWorkdaysThisYear
    SET @TotalAVGBusinessDayOrdersDiff = @TotalBusinessDayOrdersThisYearAVG
        - @TotalBusinessDayOrdersLastYearAVG

    /*SET @TotalAVGBusinessDayOrdersDiffPercentage = @TotalAVGBusinessDayOrdersDiff
        / @TotalBusinessDayOrdersThisYearAVG   10/27/2014 per R. Herbert -efw*/

    SET @TotalAVGBusinessDayOrdersDiffPercentage = @TotalAVGBusinessDayOrdersDiff
        / @TotalBusinessDayOrdersLastYearAVG 


	
    INSERT  INTO #MonthlyOrders
            ( [Year] ,
              [Month] ,
              [OrderCount] ,
              [Orders] ,
              [TicketAverage] ,
              [BusinessDays] ,
              [AVGBusinessDayOrders] ,
              [AVGBusinessDayOrdersDiff] ,
              [OrdersDiffPercentage] 
            )
    VALUES
            ( DATEPART(YEAR, DATEADD(yy, -1, @ReportDate)) ,
              13 ,
              @TotalOrderCountLastYear ,
              @TotalOrdersLastYear ,
              @TicketAverage ,
              @TotalWorkdaysLastYear ,
              @TotalBusinessDayOrdersLastYearAVG ,
              0.000000 ,
              0.000000
            )

    IF ( @TotalOrderCountThisYear > 0 )
        BEGIN
            SET @TicketAverage = ROUND(( @TotalOrdersThisYear
                                         / @TotalOrderCountThisYear ), 2)
        END
    ELSE
        BEGIN
            SET @TicketAverage = 0.000000
        END

    INSERT  INTO #MonthlyOrders
            ( [Year] ,
              [Month] ,
              [OrderCount] ,
              [Orders] ,
              [TicketAverage] ,
              [BusinessDays] ,
              [AVGBusinessDayOrders] ,
              [AVGBusinessDayOrdersDiff] ,
              [OrdersDiffPercentage] 
            )
    VALUES
            ( DATEPART(YEAR, @ReportDate) ,
              13 ,
              @TotalOrderCountThisYear ,
              @TotalOrdersThisYear ,
              @TicketAverage ,
              @TotalWorkdaysThisYear ,
              @TotalBusinessDayOrdersThisYearAVG ,
              @TotalAVGBusinessDayOrdersDiff ,
              @TotalAVGBusinessDayOrdersDiffPercentage
		    )

    SELECT
        [Year] ,
        [Month] ,
        [StoreCount] ,
        [OrderCount] ,
        ISNULL([Orders], 0) AS Orders ,
        ISNULL([TicketAverage], 0.000000) AS TicketAverage ,
        [BusinessDays] ,
        [AVGBusinessDayOrders] ,
        [AVGBusinessDayOrdersDiff] ,
        [OrdersDiffPercentage]
    FROM
        #MonthlyOrders WITH ( NOLOCK )
    ORDER BY
        [Year] ,
        [Month]

    DROP TABLE #MonthlyOrders






GO
