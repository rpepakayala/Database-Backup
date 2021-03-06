/****** Object:  StoredProcedure [dbo].[rpt_SalesComparison]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[rpt_SalesComparison]
    (
      @Country VARCHAR(50)='USA',	
      @ReportDate DATETIME = NULL
    )
AS 
    SET NOCOUNT ON
					  /* modified to use new ODS, also added more countries to split them from US.  Based on proc from original DW - efw 20130213 */
DECLARE @MonthNum INT
DECLARE @SalesMonthLastYear DATETIME
DECLARE @SalesMonthThisYear DATETIME
DECLARE @EndDateLastYear DATETIME
DECLARE @EndDateThisYear DATETIME
DECLARE @StoreCount INT
DECLARE @Sales MONEY
DECLARE @TotalSalesLastYear MONEY
DECLARE @TotalSalesThisYear MONEY
IF @ReportDate IS NULL 
    BEGIN
    
        SET @ReportDate = DATEADD(dd, -1, GETDATE())
    END

SET @SalesMonthThisYear = CAST(( CAST(YEAR(@ReportDate) AS VARCHAR(4))
                                 + '-01-01 00:00:00.000' ) AS DATETIME)
SET @SalesMonthLastYear = DATEADD(yy, -1, @SalesMonthThisYear)
SET @TotalSalesLastYear = 0
SET @TotalSalesThisYear = 0
SET @MonthNum = 1
		
CREATE TABLE #MonthlySales
    (
      [Year] INT
    , [Month] INT
    , [StoreCount] INT
    , [Sales] MONEY
    )

WHILE @MonthNum <= DATEPART(month, @ReportDate) 
    BEGIN
        IF @MonthNum = DATEPART(month, @ReportDate) 
            BEGIN
                SET @EndDateLastYear = DATEADD(dd, DATEPART(day, @ReportDate),
                                               @SalesMonthLastYear)
                SET @EndDateThisYear = DATEADD(dd, DATEPART(day, @ReportDate),
                                               @SalesMonthThisYear)
            END
        ELSE 
            BEGIN
                SET @EndDateLastYear = DATEADD(mm, 1, @SalesMonthLastYear)
                SET @EndDateThisYear = DATEADD(mm, 1, @SalesMonthThisYear)
            END

	/*--Last Year */
        SELECT  @Sales = SUM(g.Amount) * -1
              , @StoreCount = COUNT(DISTINCT ( g.ZW_Franchise_ID ))
        FROM    [FII_ODS].GL.GLFact g
                INNER JOIN [FII_ODS].Store.StoreFact s ON g.CenterKey = s.CenterKey  --g.ZW_Franchise_ID = s.ZW_Franchise_ID
				
                INNER JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
                INNER JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
        WHERE   g.AccountCode IN ( 4001, 4002, 4003, 4110, 4120 )
                AND s.StoreOpenDate <= @SalesMonthLastYear
                AND g.TransactionDateTime >= @SalesMonthLastYear
                AND g.TransactionDateTime < @EndDateLastYear
                AND c.CountryName = @Country		
              
                AND op.OperationalName <> 'Closed'
                AND ( ( SELECT  SUM(g2.Amount) * -1
                        FROM    [FII_ODS].GL.GLFact g2
                                JOIN [FII_ODS].Store.StoreFact s ON  g2.CenterKey = s.CenterKey  --g.ZW_Franchise_ID = s.ZW_Franchise_ID g2.ZW_Franchise_ID = s.ZW_Franchise_ID
                                JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
                                JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
                        WHERE   g2.AccountCode IN ( 4001, 4002, 4003, 4110,
                                                    4120 )
                                                    AND	  g.CenterKey =  g2.CenterKey -- g.ZW_Franchise_ID =  g2.ZW_Franchise_ID
                                AND g2.TransactionDateTime >= @SalesMonthThisYear
                                AND g2.TransactionDateTime < @EndDateThisYear
                      ) > 0 )
                AND ( ( SELECT  SUM(g3.Amount) * -1
                        FROM    [FII_ODS].GL.GLFact g3 WITH ( NOLOCK )
                                JOIN [FII_ODS].Store.StoreFact s ON  g3.CenterKey = s.CenterKey -- g3.ZW_Franchise_ID = s.ZW_Franchise_ID
                                JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
                                JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
                        WHERE   g3.AccountCode IN ( 4001, 4002, 4003, 4110,
                                                    4120 )
                                                      AND	 g.CenterKey =  g3.CenterKey --  g.ZW_Franchise_ID =  g3.ZW_Franchise_ID
                                AND g3.TransactionDateTime >= @SalesMonthLastYear
                                AND g3.TransactionDateTime < @EndDateLastYear
                      ) > 0 )
			
			   
								
				  
        INSERT  INTO #MonthlySales
                ( [Year]
                , [Month]
                , [StoreCount]
                , [Sales]
                )
        VALUES  ( DATEPART(year, @SalesMonthLastYear)
                , @MonthNum
                , @StoreCount
                , @Sales
                )
        SET @TotalSalesLastYear = @TotalSalesLastYear + @Sales
	
		/*--This Year */
        SELECT  @Sales = SUM(g.Amount) * -1
              , @StoreCount = COUNT(DISTINCT ( g.ZW_Franchise_ID ))																				
        FROM    [FII_ODS].GL.GLFact g
                INNER JOIN [FII_ODS].Store.StoreFact s ON g.CenterKey = s.CenterKey
                INNER JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
                INNER JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
        WHERE   g.AccountCode IN ( 4001, 4002, 4003, 4110, 4120 )
                AND s.StoreOpenDate <= @SalesMonthLastYear
                AND g.TransactionDateTime >= @SalesMonthThisYear
                AND g.TransactionDateTime < @EndDateThisYear
                AND c.CountryName = @Country 
                
                AND op.OperationalName <> 'Closed'
                AND ( ( SELECT  SUM(g2.Amount) * -1
                        FROM    [FII_ODS].GL.GLFact g2
                                JOIN [FII_ODS].Store.StoreFact s ON g2.CenterKey = s.CenterKey
                                JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
                                JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
                        WHERE   g2.AccountCode IN ( 4001, 4002, 4003, 4110,
                                                    4120 )
                                                      AND	  g.CenterKey =  g2.CenterKey
                                AND g2.TransactionDateTime >= @SalesMonthThisYear
                                AND g2.TransactionDateTime < @EndDateThisYear
                      ) > 0 )
                AND ( ( SELECT  SUM(g3.Amount) * -1
                        FROM    [FII_ODS].GL.GLFact g3 WITH ( NOLOCK )
                                JOIN [FII_ODS].Store.StoreFact s ON g3.CenterKey = s.CenterKey
                                JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
                                JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
                        WHERE   g3.AccountCode IN ( 4001, 4002, 4003, 4110,
                                                    4120 )
                                                      AND	  g.CenterKey =  g3.CenterKey
                                AND g3.TransactionDateTime >= @SalesMonthLastYear
                                AND g3.TransactionDateTime < @EndDateLastYear
                      ) > 0 )
			
			
									

        INSERT  INTO #MonthlySales
                ( [Year]
                , [Month]
                , [StoreCount]
                , [Sales]
                )
        VALUES  ( DATEPART(year, @SalesMonthThisYear)
                , @MonthNum
                , @StoreCount
                , @Sales
                )				  
        SET @TotalSalesThisYear = @TotalSalesThisYear + @Sales

        SET @MonthNum = @MonthNum + 1
        SET @SalesMonthLastYear = DATEADD(mm, 1, @SalesMonthLastYear)
        SET @SalesMonthThisYear = DATEADD(mm, 1, @SalesMonthThisYear)
        
         /*   select @MonthNum,@SalesMonthLastYear, @SalesMonthThisYear , @EndDateLastYear ,@EndDateThisYear ,	@StoreCount	 ,@Sales  for debuggin */
			  
    END

  
INSERT  INTO #MonthlySales
        ( [Year]
        , [Month]
        , [Sales]
        )
VALUES  ( DATEPART(year, DATEADD(yy, -1, @ReportDate))
        , 13
        , @TotalSalesLastYear
        )
INSERT  INTO #MonthlySales
        ( [Year]
        , [Month]
        , [Sales]
        )
VALUES  ( DATEPART(year, @ReportDate)
        , 13
        , @TotalSalesThisYear
        )

SELECT  [Year]
      , [Month]
      , [StoreCount]
      , [Sales]
FROM    #MonthlySales
ORDER BY [Year]
      , [Month]

DROP TABLE #MonthlySales


GO
