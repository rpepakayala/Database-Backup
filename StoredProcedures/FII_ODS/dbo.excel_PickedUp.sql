/****** Object:  StoredProcedure [dbo].[excel_PickedUp]    Script Date: 5/15/2018 12:09:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
--USE [FII_ODS]
--GO
--/****** Object:  StoredProcedure [dbo].[rpt_PickedUpAVGPerMonth_V6]    Script Date: 1/15/2016 1:48:12 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO


CREATE PROCEDURE [dbo].[excel_PickedUp]
    (
     @Country VARCHAR(2) = 'US'
	,@ReportMonth1 int = 2
    ,@ReportYear1 int = 2016
    )
AS
    SET NOCOUNT ON

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL
    DROP TABLE #Temp


IF OBJECT_ID('tempdb..#Loader') IS NOT NULL
    DROP TABLE #Loader


IF OBJECT_ID('tempdb..#Loaded') IS NOT NULL
    DROP TABLE #Loaded

IF OBJECT_ID('tempdb..#MissingTemp') IS NOT NULL
    DROP TABLE #MissingTemp

--DECLARE @country CHAR(2) = 'US'
DECLARE @ReportDate DATE
DECLARE @ReportMonth DATE

DECLARE @MissingDays INT
SET @MissingDays = 0
DECLARE @MissingDate DATE

DECLARE @Month INT
DECLARE @Year INT
DECLARE @FirstRun BIT = 1

DECLARE @LastYearMonth DATETIME 
DECLARE @ThisYearMonth DATETIME
DECLARE @LastYearEndMonth DATETIME
DECLARE @ThisYearEndMonth DATETIME
DECLARE @LastYearMontha DATETIME
DECLARE @ThisYearMontha DATETIME
DECLARE @LastYearEndMontha DATETIME
DECLARE @ThisYearEndMontha DATETIME 

DECLARE @ReportYear INT

DECLARE @Message VARCHAR(80)


IF @ReportDate IS NULL
    BEGIN    
        SET @ReportDate = 
		GETDATE()	  
    END

SET @MissingDate = DATEADD(DAY, -1 * @MissingDays, GETDATE())

IF @ReportMonth IS NULL
BEGIN
	
	SET @ReportMonth = DATEADD(MONTH,-1,@ReportDate)
	SET @ReportMonth = CAST(Month(@ReportMonth) AS varchar(2))+'/1/'+CAST(year(@ReportMonth) AS varchar(4))
END

IF @ReportYear IS NULL
    BEGIN  
        SET @ReportYear = YEAR(@ReportDate)
    END

--SELECT
--    GLFact.ZW_Franchise_ID ,
--    MAX(GLFact.TransactionDateTime) AS Last_TransactionDateTime
--INTO
--    #MissingTemp
--FROM
--    GL.GLFact GLFact WITH ( NOLOCK )
--GROUP BY
--    GLFact.ZW_Franchise_ID
        --HAVING
        --    MAX(GLFact.TransactionDateTime) > @MissingDate

SET @Month = 1
SET @Year = YEAR(DATEADD(YEAR, -1, GETDATE()))

WHILE ( @Year <= YEAR(GETDATE()) )
    BEGIN
        WHILE ( @Month <= 12 )
            BEGIN
				--PROC goes Here
                --SET @Message = 'Working on ' + CAST(@Month AS CHAR(2)) + '/'
                --    + CAST(@Year AS CHAR(4))
                --RAISERROR(@Message, 0, 1) WITH NOWAIT 
				          
                SET @LastYearMonth = CAST(@Month AS CHAR(2)) + '/1/'
                    + CAST(@Year - 1 AS CHAR(4))
                SET @ThisYearMonth = CAST(@Month AS CHAR(2)) + '/1/'
                    + CAST(@Year AS CHAR(4))
                SET @ThisYearEndMonth = CASE WHEN DATEADD(MONTH, 1,
                                                          @ThisYearMonth) > GETDATE() --THEN GETDATE() - 1
                                                  THEN 
                                                              CAST(CAST(MONTH(GETDATE()) AS VARCHAR(2))
                                                              + '/'
                                                              + CAST(DAY(GETDATE()) AS VARCHAR(2))
                                                              + '/'
                                                              + CAST(YEAR(GETDATE()) AS CHAR(4)) AS DATETIME)
                                             ELSE DATEADD(MONTH, 1,
                                                          @ThisYearMonth)
                                        END 
                SET @LastYearEndMonth = CASE WHEN DATEADD(MONTH, 1,
                                                          @ThisYearMonth) > GETDATE()
                                             THEN DATEADD(DAY,
                                                          DAY(GETDATE() - 1),
                                                          @LastYearMonth)
                                             ELSE DATEADD(MONTH, 1,
                                                          @LastYearMonth)
                                        END 
                
-- IF @Month=2 AND @Year=2016
--BEGIN
----SELECT @ThisYearEndMonth AS ThisYearEndMonth,
----       @LastYearEndMonth AS LastYearEndMonth        
--END	 
 
                SET @LastYearMontha = DATEADD(HOUR, -13, @LastYearMonth)
                SET @ThisYearMontha = DATEADD(HOUR, -13, @ThisYearMonth)
                SET @LastYearEndMontha = DATEADD(HOUR, -13, @LastYearEndMonth)
                SET @ThisYearEndMontha = DATEADD(HOUR, -13, @ThisYearEndMonth);

                WITH    Centers
                          AS ( SELECT
                                Store.StoreFact.CenterKey ,
                                Store.StoreFact.ZW_Franchise_ID ,
                                Store.StoreFact.StoreNumber ,
                                Store.StoreFact.OpenStatus ,
                                Store.CountryDim.CountryName AS CountryName ,
                                Store.CountryDim.CountryCode ,
                                Store.StoreFact.StoreOpenDate ,
                                System.StoreControl.DataSource ,
                                System.StoreControl.AsOfDate
                               FROM
                                Store.StoreFact
                                INNER JOIN Store.CountryDim ON Store.StoreFact.CountryKey = Store.CountryDim.CountryKey
                                LEFT JOIN System.StoreControl ON Store.StoreFact.ZW_Franchise_ID = System.StoreControl.ZW_Franchise_ID
                               -- INNER JOIN #MissingTemp LastGLTransaction ON LastGLTransaction.ZW_Franchise_ID = Store.StoreFact.ZW_Franchise_ID
                               WHERE
                                Store.StoreFact.OpenStatus = 'Open'
                                AND Store.StoreFact.OpenMonth <= @LastYearMonth
                                AND Store.CountryDim.CountryCode = @country
									-- excludes 105 and 106
                                AND ISNULL(Store.StoreFact.ExcludeFromPickedUP,
                                           0) <> 1
                             )
                    SELECT
                        Centers.CountryCode ,
                        Centers.StoreNumber ,
                        Centers.ZW_Franchise_ID ,
                        ISNULL(Centers.DataSource, 'FSI') AS DataSource ,
                        Sum13.Amount AS [13PickedUP] ,
                        Sum14.Amount AS [14PickedUP]
                    INTO
                        #Temp
                    FROM
                        Centers
                        INNER JOIN ( SELECT
                                        GLFact.ZW_Franchise_ID ,
                                        SUM(GLFact.Amount) AS Amount
                                     FROM
                                        tempGL GLFact WITH ( NOLOCK )
                                        JOIN Centers ON GLFact.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                     WHERE
                                        GLFact.TransactionDateTime >= @LastYearMonth
                                        AND GLFact.TransactionDateTime < @LastYearEndMonth
                                     GROUP BY
                                        GLFact.ZW_Franchise_ID
                                   ) Sum13 ON Sum13.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                        INNER JOIN ( SELECT
                                        GLFact.ZW_Franchise_ID ,
                                        SUM(GLFact.Amount) AS Amount
                                     FROM
                                        tempGL GLFact WITH ( NOLOCK )
                                        JOIN Centers ON GLFact.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                     WHERE
                                        GLFact.TransactionDateTime >= @ThisYearMonth
                                        AND GLFact.TransactionDateTime < @ThisYearEndMonth
                                     GROUP BY
                                        GLFact.ZW_Franchise_ID
                                   ) Sum14 ON Sum14.ZW_Franchise_ID = Centers.ZW_Franchise_ID

                IF ( @FirstRun = 1 )
                    BEGIN
                        SELECT
                            @Month AS intMonth ,
                            @Year AS EndYear ,
                            CountryCode ,
                            StoreNumber ,
                            ZW_Franchise_ID ,
  --                          ISNULL(DataSource, 'FSI') AS DataSource ,
                            [13PickedUP] AS LastYear ,
                            [14PickedUP] AS ThisYear
                        INTO
                            #Loader
                        FROM
                            #Temp
                        SET @FirstRun = 0
                    END	
                ELSE
                    INSERT  INTO #Loader
                            SELECT
                                @Month AS intMonth ,
                                @Year AS EndYear ,
                                CountryCode ,
                                StoreNumber ,
                                ZW_Franchise_ID ,
   --                             ISNULL(DataSource, 'FSI') AS DataSource ,
                                [13PickedUP] AS LastYear ,
                                [14PickedUP] AS ThisYear
                            FROM
                                #Temp;

                DROP TABLE #Temp
                SET @Month = @Month + 1
            END
        SET @Year = @Year + 1
        SET @Month = 1
    END

SELECT
    loader.EndYear ,
    loader.intMonth ,
    loader.CountryCode ,
    COUNT(ALL loader.StoreNumber) AS CentersReporting ,
    SUM(loader.LastYear) AS Sum_LastYear ,
    LastYearWorking.WorkDays AS LastYearWorkingDays ,
    SUM(loader.ThisYear) AS Sum_ThisYear ,
    WorkingDaysYTD.WorkDays AS ThisYearWorkingDays ,  	
   --   -- @AVGBusinessDaySalesLastYear  
    ( SUM(loader.LastYear) / LastYearWorking.WorkDays ) AS AVGBusinessDaySalesLastYear , 
	     --   --@AVGBusinessDaySalesThisYear  
    ( SUM(loader.ThisYear) / WorkingDaysYTD.WorkDays ) AS AVGBusinessDaySalesThisYear ,
   	       --@AVGBusinessDaySalesDiff  
    ( ( SUM(loader.ThisYear) / WorkingDaysYTD.WorkDays )
      - ( SUM(loader.LastYear) / LastYearWorking.WorkDays ) ) AS AVGBusinessDaySalesDiff ,
				
	  --@AVGSalesDiffPercentage  
    ( ( ( SUM(loader.ThisYear) / WorkingDaysYTD.WorkDays )
        - ( SUM(loader.LastYear) / LastYearWorking.WorkDays ) )
      / ( SUM(loader.LastYear) / LastYearWorking.WorkDays ) ) AS AVGSalesDiffPercentage
INTO
    #Loaded
FROM
    #Loader loader
    INNER JOIN ( SELECT
                    YEAR(System.Calendar.dt) AS intYear ,
                    MONTH(System.Calendar.dt) AS intMonth ,
                    COUNT(*) AS WorkDays
                 FROM
                    System.Calendar
                 WHERE
                    System.Calendar.IsWorkDay = 1
                    AND System.Calendar.dt < GETDATE() - 1
                 GROUP BY
                    YEAR(System.Calendar.dt) ,
                    MONTH(System.Calendar.dt)
               ) WorkingDaysYTD ON WorkingDaysYTD.intYear = loader.EndYear
                                   AND WorkingDaysYTD.intMonth = loader.intMonth
    INNER JOIN ( SELECT
                    YEAR(System.Calendar.dt) AS intYear ,
                    MONTH(System.Calendar.dt) AS intMonth ,
                    COUNT(*) AS WorkDays
                 FROM
                    System.Calendar
                 WHERE
                    System.Calendar.IsWorkDay = 1
                    AND System.Calendar.dt < DATEADD(YEAR, -1,
                                                     ( GETDATE() - 1 ))
                 GROUP BY
                    YEAR(System.Calendar.dt) ,
                    MONTH(System.Calendar.dt)
               ) LastYearWorking ON LastYearWorking.intYear = loader.EndYear
                                    - 1
                                    AND LastYearWorking.intMonth = loader.intMonth
GROUP BY
    loader.intMonth ,
    loader.EndYear ,
    loader.CountryCode ,
    LastYearWorking.WorkDays ,
    WorkingDaysYTD.WorkDays
ORDER BY
    loader.CountryCode ,
    loader.EndYear ,
    loader.intMonth


-- To show the current MTD
SELECT
    #Loader.intMonth ,
    #Loader.EndYear ,
    #Loader.CountryCode ,
    #Loader.StoreNumber ,
    #Loader.ZW_Franchise_ID ,
    #Loader.LastYear ,
    #Loader.ThisYear,
	#Loader.ThisYear-#Loader.LastYear AS 'TY-LY',
	CASE WHEN System.StoreControl.DataSource IS NULL THEN RPM.Last_UpdateDate ELSE NULL END AS Last_UpdateDate,
	CASE WHEN System.StoreControl.DataSource IS NULL THEN RPM.Last_PickedUpDate ELSE NULL END AS Last_PickedUpDate,
	ISNULL(System.StoreControl.DataSource,'FSI') AS DataSource,
	Royalty.CenterSales.TotalSales AS RoyaltySales,LY.TotalSales AS LYRoyaltySales,
	Shipping.Shipping_Amount,
	#Loader.ThisYear+ISNULL(Shipping.Shipping_Amount,0) AS [TY+Shipping],
	store.StoreFact.StoreOpenDate AS OpenDate
FROM
    #Loader
LEFT JOIN (Select
  Orders.OrderHeaderFact.ZW_Franchise_ID,
  MAX(Orders.OrderHeaderFact.OLTP_UpdateDate)
    As Last_UpdateDate,
  Max(Orders.OrderHeaderFact.PickedUpDate) As Last_PickedUpDate
From
  Orders.OrderHeaderFact
Group By
  Orders.OrderHeaderFact.ZW_Franchise_ID) RPM ON RPM.ZW_Franchise_ID = #Loader.ZW_Franchise_ID
    LEFT JOIN ( SELECT
                    vw_Locations.ZW_Franchise_ID ,
                    SUM(SalesResultsAllDispositions.Amount) AS Shipping_Amount
                FROM
                    CoreBridgeCentral.dbo.SalesResultsAllDispositions
                    INNER JOIN CoreBridgeCentral.dbo.vw_Locations ON vw_Locations.Value = SalesResultsAllDispositions.CompanyLocationId
                WHERE
                    SalesResultsAllDispositions.GL_Account LIKE '%ship%'
                    AND YEAR(SalesResultsAllDispositions.OrderCompletionDate) = @ReportYear1
                    AND MONTH(SalesResultsAllDispositions.OrderCompletionDate) = @ReportMonth1
                GROUP BY
                    vw_Locations.ZW_Franchise_ID
                HAVING
                    SUM(SalesResultsAllDispositions.Amount) <> 0
              ) Shipping ON Shipping.ZW_Franchise_ID = #Loader.ZW_Franchise_ID    
LEFT JOIN System.StoreControl ON StoreControl.ZW_Franchise_ID = #Loader.ZW_Franchise_ID
LEFT JOIN store.StoreFact ON StoreFact.ZW_Franchise_ID = #Loader.ZW_Franchise_ID
LEFT JOIN Royalty.CenterSales ON CenterSales.StoreNumber = #Loader.StoreNumber AND 
MONTH(Royalty.CenterSales.PeriodEndDate)=@ReportMonth1 AND 
YEAR(Royalty.CenterSales.PeriodEndDate)=@ReportYear1
LEFT JOIN Royalty.CenterSales LY ON LY.StoreNumber = #Loader.StoreNumber AND 
MONTH(LY.PeriodEndDate)=@ReportMonth1 AND 
YEAR(LY.PeriodEndDate)=@ReportYear1-1
WHERE
    intMonth = @ReportMonth1
    AND EndYear = @ReportYear1
GO
