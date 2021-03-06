/****** Object:  StoredProcedure [dbo].[usp_SalesAndGoals]    Script Date: 5/15/2018 12:09:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE PROCEDURE [dbo].[usp_SalesAndGoals]
(
@dateto datetime, 
@franchise varchar(7),
@OpenDate datetime
)
AS
BEGIN


    SET NOCOUNT ON;

    --PRINT 'begin: ' 
    --PRINT CONVERT(VARCHAR(30), GETDATE()) + ':'
    --    + CONVERT(VARCHAR(30), DATEPART(ss, GETDATE())) + +':'
    --    + CONVERT(VARCHAR(30), DATEPART(ms, GETDATE()))

    DECLARE @lastFinished DATETIME
    DECLARE @difference FLOAT
    SET @lastFinished = GETDATE()

    DECLARE @date DATETIME
      , @dateLY DATETIME
      , @datePLY DATETIME
    SET @date = DATEADD(hh, -13, @dateto)

    DECLARE @dailyCloseoutEnd DATETIME
    SELECT  @dailyCloseoutEnd = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'D'
            AND Date < @date
            AND zw_franchise_id = @franchise
    DECLARE @dailyCloseoutStart DATETIME
    SELECT  @dailyCloseoutStart = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'D'
            AND Date < @dailyCloseoutEnd
            AND zw_franchise_id = @franchise
    DECLARE @monthlyCloseout DATETIME
    SELECT  @monthlyCloseout = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'M'
            AND Date < @date
            AND zw_franchise_id = @franchise
    IF DATEDIFF(dd, @monthlyCloseout, @dailyCloseoutEnd) < 1 
        BEGIN 
            SELECT  @monthlyCloseout = COALESCE(MAX(Date), '1/1/1900')
            FROM    [Closeout Database]
            WHERE   CloseoutType = 'M'
                    AND Date < @monthlyCloseout
                    AND zw_franchise_id = @franchise
        END
    DECLARE @yearlyCloseout DATETIME
    SELECT  @yearlyCloseout = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'Y'
            AND Date < @date
            AND zw_franchise_id = @franchise
    DECLARE @preMonthlyCloseout DATETIME
    SELECT  @preMonthlyCloseout = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'M'
            AND Date < @monthlyCloseout
            AND zw_franchise_id = @franchise

    SET @dateLY = CAST(MONTH(@dailyCloseoutEnd) AS VARCHAR(2)) + '/'
        + CAST(DAY(@dailyCloseoutEnd) AS VARCHAR(2)) + '/'
        + CAST(( YEAR(@dailyCloseoutEnd) - 1 ) AS VARCHAR(4)) + '  10:59:59' 
    SET @datePLY = CAST(MONTH(@dailyCloseoutEnd) AS VARCHAR(2)) + '/'
        + CAST(DAY(@dailyCloseoutEnd) AS VARCHAR(2)) + '/'
        + CAST(( YEAR(@dailyCloseoutEnd) - 2 ) AS VARCHAR(4)) + '  10:59:59' 

    DECLARE @rolling12Start DATETIME
    SELECT  @rolling12Start = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'D'
            AND Date < @dateLY
            AND zw_franchise_id = @franchise
    DECLARE @dailyCloseoutEndLY DATETIME
    SELECT  @dailyCloseoutEndLY = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'D'
            AND Date < @dateLY
            AND zw_franchise_id = @franchise
    DECLARE @dailyCloseoutStartLY DATETIME
    SELECT  @dailyCloseoutStartLY = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'D'
            AND Date < @dailyCloseoutEndLY
            AND zw_franchise_id = @franchise
    DECLARE @monthlyCloseoutLY DATETIME
    SELECT  @monthlyCloseoutLY = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'M'
            AND Date < @dateLY
            AND zw_franchise_id = @franchise
    DECLARE @yearlyCloseoutLY DATETIME
    SELECT  @yearlyCloseoutLY = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'Y'
            AND Date < DATEADD(d, 0, DATEDIFF(d, 0, @yearlyCloseout))
            AND zw_franchise_id = @franchise
    IF YEAR(@yearlyCloseoutLY) - YEAR(@yearlyCloseout) = 0 
        BEGIN
            SET @yearlyCloseoutLY = DATEADD(yy, -1,
                                            DATEDIFF(d, 0, @yearlyCloseout))	
        END
    DECLARE @rolling12StartLY DATETIME
    SELECT  @rolling12StartLY = COALESCE(MAX(Date), '1/1/1900')
    FROM    [Closeout Database]
    WHERE   CloseoutType = 'D'
            AND Date < @datePLY
            AND zw_franchise_id = @franchise

    DECLARE @DaysInMonth FLOAT /* Float needed for currency division */
    SET @DaysInMonth = DAY(DATEADD(d, -DAY(DATEADD(m, 1, @date)),
                                   DATEADD(m, 1, @date)))
    DECLARE @RollingTwelveDate DATETIME
    SET @RollingTwelveDate = DATEADD(year, -1, @date)
    DECLARE @beginningOfMonth DATETIME
    SET @beginningOfMonth = [dbo].[ufn_GetFirstDayOfMonth](@dailyCloseoutEnd)
    DECLARE @FractionOfMonth FLOAT
    SET @FractionOfMonth = CONVERT(FLOAT, DATEDIFF(day, @monthlyCloseout,
                                                   @dailyCloseoutEnd))
        / CONVERT(FLOAT, @DaysInMonth)
    DECLARE @maxYear SMALLINT
    SELECT  @maxYear = MAX(year)
    FROM    [Sales Goals Database]
    WHERE   zw_franchise_id = @franchise
            AND Year <= DATEPART(yy, GETDATE())



    IF YEAR(@yearlyCloseoutLY) < ( YEAR(@dateto) - 2 )
        AND ( YEAR(@openDate) NOT IN ( YEAR(@date), YEAR(@date) - 1 )
              OR YEAR(@openDate) IS NULL
            ) 
        BEGIN
            SELECT  ( 'Through Date of Last Closeouts: '
                      + CONVERT(VARCHAR(20), DATEADD(hh, 13, @dailyCloseoutEnd))
                      + '(D) --- ' + CONVERT(VARCHAR(20), DATEADD(hh, 13,
                                                              @monthlyCloseout))
                      + '(M) --- ' + CONVERT(VARCHAR(20), DATEADD(hh, 13,
                                                              @yearlyCloseout))
                      + '(Y)' ) AS DateUsed
                  , '1/1/1900' dateto
                  , @dailyCloseoutStart dailyCloseoutStart
                  , @dailyCloseoutEnd dailyCloseoutEnd
                  , @monthlyCloseout monthlyCloseout
                  , @yearlyCloseoutLY
            RETURN
        END
    IF YEAR(@yearlyCloseoutLY) < ( YEAR(@dateto) - 2 )
        AND YEAR(@openDate) IN ( YEAR(@date), YEAR(@date) - 1 ) 
        BEGIN
            IF YEAR(@openDate) = YEAR(@date) 
                BEGIN
                    SET @yearlyCloseout = DATEADD(dd, DATENAME(dy, @Date) * -1,
                                                  @date)
                    SET @yearlyCloseoutLY = DATEADD(yy, -1, @yearlyCloseout)
                END
            IF YEAR(@openDate) = ( YEAR(@date) - 1 ) 
                BEGIN
                    SET @yearlyCloseoutLY = DATEADD(yy, -1, @yearlyCloseout)
                END
        END


/* CREATE TEMP TABLE FOR HOLDING CUSTOMER FIRST ORDER DATE*/
    DECLARE @tFirstTimeCustomersYTD TABLE
        (
          CustomerID INT
        , FirstOrderDate DATETIME
        )
    INSERT  INTO @tFirstTimeCustomersYTD
            SELECT  customerID
                  , COALESCE(MIN(OrderDate), '1900-01-01')
            FROM    [ORDER Database]
            WHERE   zw_franchise_id = @franchise
                    AND status <> 'voided'
            GROUP BY customerID
            HAVING  COALESCE(MIN(OrderDate), '1900-01-01') >= @yearlyCloseoutLY

    --PRINT 'end create temp'
    --PRINT ''

    SET @difference = DATEDIFF(ms, @lastFinished, GETDATE())
    --PRINT CAST(@difference AS VARCHAR(7)) + ' milliseconds'
    SET @lastFinished = GETDATE()

/* Use Temp Table to get count of YTD First Time Customers and Previous YTD too */
    DECLARE @CustYTD INT
      , @CustYTDLY INT
    SELECT  @CustYTD = COUNT(CASE WHEN FirstOrderDate BETWEEN @yearlyCloseout
                                                      AND     @dailyCloseoutEnd
                                  THEN CustomerID
                             END)
          , @CustYTDLY = COUNT(CASE WHEN FirstOrderDate BETWEEN @yearlyCloseoutLY
                                                        AND   @dailyCloseoutEndLY
                                    THEN CustomerID
                               END)
    FROM    @tFirstTimeCustomersYTD

-----------------------------------------------------------------

    DECLARE @customercount TABLE
        (
          CustomerID INT
        , OrderID INT
        )
    DECLARE @NoInvoicesYTD INT
      , @NoInvoicesYTDLY INT
      , @FirstOrderDate DATETIME
      , @SalesSubtotal MONEY
    DECLARE @TotalInvoicesYTD MONEY
      , @TotalInvoicesYTDLY MONEY
    DECLARE @overridesYTD INT
      , @overridesYTDLY INT
      , @orderOverrides INT

    SET @NoInvoicesYTD = 0
    SET @NoInvoicesYTDLY = 0
    SET @TotalInvoicesYTD = 0
    SET @TotalInvoicesYTDLY = 0
    SET @overridesYTD = 0
    SET @overridesYTDLY = 0

    DECLARE @OrderID INT
    DECLARE @customerID INT

    DECLARE ordercur CURSOR LOCAL FAST_FORWARD
    FOR
        SELECT  o.OrderId
              , o.CustomerId
              , o.SalesSubtotal
        FROM    [Order Database] o
        WHERE   o.orderDate >= @yearlyCloseoutLY
                AND o.zw_franchise_id = @franchise

    OPEN ordercur

    FETCH NEXT FROM ordercur
INTO @OrderID, @customerID, @SalesSubtotal

    WHILE @@FETCH_STATUS = 0 
        BEGIN
	/* must 'reset' this as the SELECT assignment doesn't seem to clear it out on its own */
            SET @FirstOrderDate = '1900-01-01'

            SELECT  @FirstOrderDate = COALESCE(FirstOrderDate, '1900-01-01')
            FROM    @tFirstTimeCustomersYTD
            WHERE   customerID = @customerID

            SET @orderOverrides = 0
		
            IF ( @FirstOrderDate BETWEEN @yearlyCloseoutLY
                                 AND     @dailyCloseoutEnd ) 
                BEGIN
                    SELECT  @orderOverrides = SUM(CAST(BasePriceOverriden AS TINYINT)
                                                  + CAST(OverRidden AS TINYINT)
                                                  + CAST(AVOverridden AS TINYINT))
                    FROM    [Order Details Database] /* WITH (INDEX(Idx_OrderID_FranchiseID)) */
                    WHERE   OrderID = @OrderID
                            AND zw_franchise_id = @franchise
                    GROUP BY OrderID
                    OPTION  ( FAST 5 )

                    IF ( @orderOverrides > 0 ) 
                        SET @orderOverrides = 1
                END

            IF ( @FirstOrderDate BETWEEN @yearlyCloseout
                                 AND     @dailyCloseoutEnd ) 
                BEGIN
                    SET @NoInvoicesYTD = @NoInvoicesYTD + 1
                    SET @TotalInvoicesYTD = @TotalInvoicesYTD + @SalesSubtotal
                    SET @overridesYTD = @overridesYTD + @orderOverrides
                END
            ELSE 
                IF ( @FirstOrderDate BETWEEN @yearlyCloseoutLY
                                     AND     @dailyCloseoutEndLY ) 
                    BEGIN
                        SET @NoInvoicesYTDLY = @NoInvoicesYTDLY + 1
                        SET @TotalInvoicesYTDLY = @TotalInvoicesYTDLY
                            + @SalesSubtotal
                        SET @overridesYTDLY = @overridesYTDLY
                            + @orderOverrides
                    END

            FETCH NEXT FROM ordercur
INTO @OrderID, @customerId, @SalesSubtotal
        END

    CLOSE ordercur

    DEALLOCATE ordercur

   -- PRINT ''
    --PRINT 'finish order cursor'
    SET @difference = DATEDIFF(ms, @lastFinished, GETDATE())
   -- PRINT CAST(@difference AS VARCHAR(7)) + ' milliseconds'
    SET @lastFinished = GETDATE()
    --PRINT ''
	

/*-----------------------------------------------------------------------------------------------------------------*/


    SELECT  *
    FROM    ( SELECT    ( 'Through Date of Last Closeouts: '
                          + CONVERT(VARCHAR(20), DATEADD(hh, 12,
                                                         @dailyCloseoutEnd))
                          + '(D) --- ' + CONVERT(VARCHAR(20), DATEADD(hh, 13,
                                                              @monthlyCloseout))
                          + '(M) --- ' + CONVERT(VARCHAR(20), DATEADD(hh, 13,
                                                              @yearlyCloseout))
                          + '(Y)' ) AS DateUsed
                      , @date dateto
                      , @dailyCloseoutStart dailyCloseoutStart
                      , @dailyCloseoutEnd dailyCloseoutEnd
                      , @monthlyCloseout monthlyCloseout
                      ,

--isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  DATETIME between @dailyCloseoutStart and @dailyCloseoutEnd
--THEN -Amount 
--WHEN AccountCode IN (1250, 1260) and DATETIME between @dailyCloseoutStart and @dailyCloseoutEnd
--THEN Amount 
--ELSE 0 END ),0) DailyPlacedAmount,

                        ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @monthlyCloseout
                                                          AND @dailyCloseoutEnd
                                        THEN -Amount
                                        WHEN AccountCode IN ( 1250, 1260 )
                                             AND DATETIME BETWEEN @monthlyCloseout
                                                          AND @dailyCloseoutEnd
                                        THEN Amount
                                        ELSE 0
                                   END), 0) TotalAmountPlacedMTD
                      ,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and DATETIME between @yearlyCloseout and @dailyCloseoutEnd 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and DATETIME between @yearlyCloseout and @dailyCloseoutEnd
	THEN Amount
ELSE 0 END ),0) CurrentYTD,

--isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and DATETIME between  @rolling12Start and @dailyCloseoutEnd 
--THEN -Amount 
--WHEN AccountCode IN (1250, 1260) and DATETIME between  @rolling12Start and @dailyCloseoutEnd
--	THEN Amount
--ELSE 0 END ),0) CurrentRollingTwelve,




----isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  DATETIME between @dailyCloseoutStart and @dailyCloseoutEnd
----THEN -Amount 
----ELSE 0 END ),0) DailyPickedUp,
                        ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @monthlyCloseout
                                                          AND @dailyCloseoutEnd
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) MTDPickedUp
                      , ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @yearlyCloseout
                                                          AND @dailyCloseoutEnd
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) YTDPickedUp
                      ,

----isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and DATETIME between  @rolling12Start and @dailyCloseoutEnd 
----THEN -Amount 
----ELSE 0 END ),0) R12PickedUp,

----isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  DATETIME between @dailyCloseoutStartLY and @dailyCloseoutEndLY
----THEN -Amount 
----ELSE 0 END ),0) DailyPickedUpLY,
                        ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @monthlyCloseoutLY
                                                          AND @dailyCloseoutEndLY
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) MTDPickedUpLY
                      , ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @yearlyCloseoutLY
                                                          AND @dailyCloseoutEndLY
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) YTDPickedUpLY
                      ,


--isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and DATETIME between @dailyCloseoutStart and @dailyCloseoutEnd
--THEN -Amount 
--WHEN AccountCode IN (1260) and DATETIME between @dailyCloseoutStart and @dailyCloseoutEnd
--	THEN Amount
--ELSE 0 END ),0) DailyBuiltAmount,

--isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and DATETIME between @monthlyCloseout and @dailyCloseoutEnd
--THEN -Amount 
--WHEN AccountCode IN (1260) and DATETIME between @monthlyCloseout and @dailyCloseoutEnd
--	THEN Amount
--ELSE 0 END ),0) TotalAmountBuiltMTD,

                        ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @dailyCloseoutStart
                                                          AND @dailyCloseoutEnd
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) DailyPickedUpAmount
                      , ISNULL(SUM(CASE WHEN AccountCode IN ( 4001, 4002, 4003,
                                                              4110, 4120 )
                                             AND DATETIME BETWEEN @monthlyCloseout
                                                          AND @dailyCloseoutEnd
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) TotalAmountPickedUpMTD

--isnull(Sum(CASE WHEN AccountCode IN (1100) and DATETIME between @dailyCloseoutStart and @dailyCloseoutEnd 
--THEN Amount
--ELSE 0 END ),0) DailyPaymentAmount,

--isnull(Sum(CASE WHEN AccountCode IN (1100) and DATETIME between @monthlyCloseout and @dailyCloseoutEnd 
--THEN Amount
--ELSE 0 END ),0) TotalAmountPaymentMTD,

--isnull(Sum(CASE WHEN AccountCode in (4001, 4003, 4110, 4120) and SubAccountCode = 100 and DateTime between @yearlyCloseout and @dailyCloseoutEnd
--THEN -Amount
--	ELSE 0
--END),0) SignSales,

--isnull(Sum(CASE WHEN AccountCode in (4001, 4003, 4110, 4120) and SubAccountCode = 200 and DateTime between @yearlyCloseout and @dailyCloseoutEnd
--THEN -Amount
--	ELSE 0
--END),0) ModifierSales,

--isnull(Sum(CASE WHEN AccountCode in (4001, 4002, 4003, 4110, 4120) and SubAccountCode = 400 and DateTime between @yearlyCloseout and @dailyCloseoutEnd
--THEN -Amount
--	ELSE 0
--END),0) InstallSales,

--isnull(Sum(CASE WHEN AccountCode in (4120) and DateTime between @yearlyCloseout and @dailyCloseoutEnd
--THEN Amount
--WHEN AccountCode in (4001, 4003, 4110) and SubAccountCode = 300 and DateTime between @yearlyCloseout and @dailyCloseoutEnd
--THEN Amount
--	ELSE 0
--END),0) DiscountSales, 

                      , ISNULL(SUM(CASE WHEN AccountCode IN ( 4002 )
                                             AND SubAccountCode <> 400
                                             AND DateTime BETWEEN @yearlyCloseout
                                                          AND @dailyCloseoutEnd
                                        THEN -Amount
                                        ELSE 0
                                   END), 0) SubcontractSales
              FROM      [GL Database]
              WHERE     DATETIME BETWEEN @rolling12StartLY
                                 AND     @dailyCloseoutEnd
                        AND zw_franchise_id = @franchise
            ) tGL
            INNER JOIN ( SELECT ISNULL(SUM(CASE WHEN ClosedDate BETWEEN @dailyCloseoutStart
                                                              AND
                                                              @dailyCloseoutEnd
                                                THEN SalesSubTotal
                                                ELSE 0
                                           END), 0) DailyClosedAmount
                              , ISNULL(SUM(CASE WHEN ClosedDate BETWEEN @monthlyCloseout
                                                              AND
                                                              @dailyCloseoutEnd
                                                THEN SalesSubTotal
                                                ELSE 0
                                           END), 0) TotalAmountClosedMTD
                              ,

--isnull (Sum(CASE WHEN  PickedUpDate between @yearlyCloseout and @dailyCloseoutEnd
--	THEN ProductionCat2Sales
--ELSE 0 END),0) SubcontractSales,

                                ISNULL(AVG(CASE WHEN OrderDate BETWEEN @yearlyCloseout
                                                              AND
                                                              @dailyCloseoutEnd
                                                THEN SalesSubTotal
                                           END), 0) YTDAvg
                              , ISNULL(AVG(CASE WHEN OrderDate BETWEEN @yearlyCloseoutLY
                                                              AND
                                                              @dailyCloseoutEndLY
                                                THEN SalesSubTotal
                                           END), 0) LYYTDAvg
                              , ISNULL(AVG(CASE WHEN OrderDate BETWEEN @rolling12Start
                                                              AND
                                                              @dailyCloseoutEnd
                                                THEN SalesSubTotal
                                           END), 0) LastTwelveMonths
                              , ISNULL(AVG(CASE WHEN OrderDate BETWEEN @rolling12StartLY
                                                              AND
                                                              @rolling12Start
                                                THEN SalesSubTotal
                                           END), 0) PreviousTwelveMonths
                              , ISNULL(SUM(CASE WHEN OrderDate < @monthlyCloseout
                                                     AND OrderDate > @preMonthlyCloseout
                                                THEN SalesSubtotal
                                                ELSE 0
                                           END), 0) AS LastMonthSales
                         FROM   [Order Database]
                         WHERE  ( ClosedDate BETWEEN @monthlyCloseout
                                             AND     @dailyCloseoutEnd
                                  AND [Order Database].zw_franchise_id = @franchise
                                )
                                OR ( PickedUpDate BETWEEN @yearlyCloseout
                                                  AND     @dailyCloseoutEnd
                                     AND [Order Database].zw_franchise_id = @franchise
                                   )
                                OR ( OrderDate BETWEEN @rolling12StartLY
                                               AND     @dailyCloseoutEnd
                                     AND [Order Database].zw_franchise_id = @franchise
                                   )
                       ) tOrder ON 1 = 1

--INNER JOIN

--(Select
--ISNULL(SUM(Amount),0) as WIP
--FROM [Order Database] o
--inner join [GL Database] g on g.orderID = o.orderId and g.zw_franchise_id = o.zw_franchise_id and g.accountcode in (1250,1260)
--WHERE OrderDate < @dailyCloseoutEnd AND Status IN ('WIP', 'Built')and o.zw_franchise_id = @franchise) tWIP on 1=1


            INNER JOIN ( SELECT ISNULL(SUM(CASE WHEN Month = DATEPART(mm,
                                                              @dailyCloseoutEnd)
                                                THEN SalesTotal
                                                ELSE 0
                                           END), 0) AS MonthlySalesGoal
                              , ISNULL(SUM(CASE WHEN Month = DATEPART(mm,
                                                              @dailyCloseoutEnd)
                                                THEN SalesTotal
                                                ELSE 0
                                           END), 0) / @DaysInMonth AS TYForecastYesterday
                              , ISNULL(SUM(CASE WHEN Month = DATEPART(mm,
                                                              @dailyCloseoutEnd)
                                                THEN SalesTotal
                                                ELSE 0
                                           END), 0) * @FractionOfMonth AS TYForecastMTD
                              , ISNULL(SUM(CASE WHEN Month < DATEPART(mm,
                                                              @dailyCloseoutEnd)
                                                THEN SalesTotal
                                                ELSE 0
                                           END), 0) AS TYForecastToLastMonth
                              , ISNULL(SUM(SalesTotal), 0) AS TYForecastRolling12
                         FROM   [Sales Goals Database]
                         WHERE  zw_franchise_id = @franchise
                                AND Year = @maxYear
                       ) tSalesGoal ON 1 = 1
					   


END


GO
