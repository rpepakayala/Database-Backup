/****** Object:  StoredProcedure [dbo].[rpt_PickedUpAVGPerMonth_V7]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE PROCEDURE [dbo].[rpt_PickedUpAVGPerMonth_V7]
    (
      @Country VARCHAR(2) = 'US' ,
      @ReportDate DATE = NULL ,
      @MissingDays INT = 7
    )
AS -- new Proc

    SET NOCOUNT ON

    IF OBJECT_ID('tempdb..#Temp') IS NOT NULL
        DROP TABLE #Temp


    IF OBJECT_ID('tempdb..#Loader') IS NOT NULL
        DROP TABLE #Loader
		
    IF OBJECT_ID('tempdb..#Loaded') IS NOT NULL
        DROP TABLE #Loaded

    IF OBJECT_ID('tempdb..#MissingTemp') IS NOT NULL
        DROP TABLE #MissingTemp

-- To Check for Correct ETL
    IF OBJECT_ID('tempdb..#Check') IS NOT NULL
        DROP TABLE #Check

-- To Check for Correct ETL
    IF OBJECT_ID('tempdb..#Check2') IS NOT NULL
        DROP TABLE #Check2

    SELECT DISTINCT 
    --FII_ODS.System.ETLHistory.PackageName ,
            FII_ODS.System.ETLHistory.System 
	--,
 --   SSISPackageExecutionLog.ExecutionEndDateTime ,
 --   SSISPackageExecutionLog.TotalErrorCount
    INTO    #Check
    FROM    ODS_Config.dbo.SSISPackageExecutionLog SSISPackageExecutionLog
            JOIN FII_ODS.System.ETLHistory ON FII_ODS.System.ETLHistory.PackageID = SSISPackageExecutionLog.PackageID
    WHERE   FII_ODS.System.ETLHistory.PackageName = 'GLFact'
            AND CAST(SSISPackageExecutionLog.ExecutionEndDateTime AS DATETIME) > = GETDATE()
            - 1
            AND SSISPackageExecutionLog.TotalErrorCount = 0
            AND System = 'GLFactLoad'

--ORDER BY
--    SSISPackageExecutionLog.ExecutionEndDateTime DESC
    IF @@ROWCOUNT < 1
        BEGIN 
            RAISERROR('Warning Not All ETL Completed, GL Temp Files Not Loaded', 17, 1) WITH LOG
            RETURN -1
        END 


    SELECT  Driver.Type ,
            Driver.SourceName ,
            SUM(Driver.RecordCount) AS RecordCount ,
            Driver.LogDate
    INTO    #Check2
    FROM    ( SELECT    'ODS GLFact' AS Type ,
                        SourceName ,
                        RecordCount ,
                        CAST(LogDate AS DATE) AS LogDate
              FROM      ODS_Config.bix.vw_SSISPackageRowCountLog_59
              WHERE     SourceID = '{D97FBF02-8982-4BA5-B889-CA2843EB44A5}'
                        AND ComponentTypeCode = 'DEST'
                        AND CAST(LogDate AS DATE) > GETDATE() - 1
              UNION
              SELECT    'CB GLFact' AS Type ,
                        SourceName ,
                        RecordCount ,
                        CAST(LogDate AS DATE) AS LogDate
              FROM      ODS_Config.bix.vw_SSISPackageRowCountLog_59
              WHERE     SourceID = '{FE38FEC7-C25E-42C0-B0B0-5AB10B71B937}'
                        AND ComponentTypeCode = 'DEST'
                        AND CAST(LogDate AS DATE) > GETDATE() - 1
            ) Driver
    GROUP BY Driver.Type ,
            Driver.SourceName ,
            Driver.LogDate

    DECLARE @RecordProcessedCheck INT
    SET @RecordProcessedCheck = 0
    SELECT  @RecordProcessedCheck = RecordCount
    FROM    #Check2
    WHERE   Type = 'CB GLFact'

    IF @RecordProcessedCheck < 1
        BEGIN 
            RAISERROR('Warning Not All ETL Completed, No Corebridge GL Loaded', 17, 1) WITH LOG
            RETURN -1
        END 
---
    SET @RecordProcessedCheck = 0
    SELECT  @RecordProcessedCheck = RecordCount
    FROM    #Check2
    WHERE   Type = 'ODS GLFact'
    IF @RecordProcessedCheck < 1
        BEGIN 
            RAISERROR('Warning Not All ETL Completed, No RPM GL Loaded', 17, 1) WITH LOG
            RETURN -1
        END 
---
---- Check for RPM Collection Completion
    DECLARE @RPMCenters FLOAT
    DECLARE @RPMCollection FLOAT 
    SET @RPMCollection = ( SELECT   CentersReporting
                           FROM     System.RPMHistory
                           WHERE    DateProcessed = CAST(GETDATE() AS DATE)
                         )

    SET @RPMCenters = ( SELECT  COUNT(DISTINCT vw_Store.ZW_Franchise_ID)
                        FROM    vw_Store
                                LEFT JOIN System.StoreControl ON vw_Store.ZW_Franchise_ID = System.StoreControl.ZW_Franchise_ID
                        WHERE   System.StoreControl.DataSource IS NULL
                                AND vw_Store.OpenStatus = 'Open'
                      )

    IF ( @RPMCollection / @RPMCenters * 100 < 60
         AND DATEPART(WEEKDAY, GETDATE()) > 2
       )
        BEGIN 
            RAISERROR('Warning Not All ETL Completed, RPM Collection Errors check with Bart', 17, 1) WITH LOG
            RETURN -1
        END 

---- Check SalesRecords Processed
--    DECLARE @recCount INT
--    DECLARE @strVar VARCHAR(2000)
--    DECLARE @Subj VARCHAR(200) ,
--        @bod VARCHAR(4000)

--    SET @recCount = 0

--    SELECT TOP 1
--            @recCount = ISNULL(SSISPackageRowCountLog.RecordCount, 0) ,
--            @strVar = SSISPackageExecutionLog.Variables
--    FROM    ODS_Config.dbo.SSISPackageExecutionLog SSISPackageExecutionLog
--            INNER JOIN ODS_Config.dbo.SSISPackageRowCountLog SSISPackageRowCountLog ON SSISPackageExecutionLog.ExecutionID = SSISPackageRowCountLog.ExecutionID
--    WHERE   CAST(SSISPackageExecutionLog.ExecutionEndDateTime AS DATE) = CAST(GETDATE() AS DATE)
--            AND SSISPackageExecutionLog.PackageName = 'DailyLoad'
--            AND SSISPackageRowCountLog.SourceName = 'Load New'
--            AND SSISPackageRowCountLog.ComponentTypeCode = 'DEST'
--    ORDER BY SSISPackageExecutionLog.ExecutionEndDateTime DESC

--    IF @recCount < 1
--        BEGIN 
--            RAISERROR('Warning Not All ETL Completed,No records processed for SalesResultsAllDispositions.', 17, 1) WITH LOG
--            RETURN -1
--        END 


--DECLARE @country CHAR(2) = 'US'
--DECLARE @ReportDate DATE = '8/25/16'

--DECLARE @MissingDays INT
--SET @MissingDays = 0


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

-- New 13 Month
    DECLARE @CompDate DATE


    IF @ReportDate IS NULL
        BEGIN
            SET @ReportDate = GETDATE()
	       
        END

    SET @ReportDate = CAST(CAST(MONTH(@ReportDate) AS VARCHAR(2)) + '/'
        + CAST(DAY(@ReportDate) AS VARCHAR(2)) + '/'
        + CAST(YEAR(@ReportDate) AS CHAR(4)) AS DATETIME)


    SET @MissingDate = DATEADD(DAY, -1 * @MissingDays, GETDATE())

    IF @ReportYear IS NULL
        BEGIN  
            SET @ReportYear = YEAR(@ReportDate)
        END


    SET @Month = 1
    SET @Year = YEAR(DATEADD(YEAR, -1, GETDATE()))

    IF @MissingDays < 2
        SET @MissingDays = 1000
    SET @MissingDate = DATEADD(DAY, -1 * @MissingDays, @ReportDate)

    --IF OBJECT_ID('tempdb..#MissingTemp') IS NULL
    --    SELECT
    --        GLFact.ZW_Franchise_ID ,
    --        MAX(GLFact.TransactionDateTime) AS Last_TransactionDateTime
    --    INTO
    --        #MissingTemp
    --    FROM
    --        GL.GLFact GLFact WITH ( NOLOCK )
    --    GROUP BY
    --        GLFact.ZW_Franchise_ID
    --    HAVING
    --        MAX(GLFact.TransactionDateTime) > @MissingDate

    WHILE ( @Year <= YEAR(GETDATE()) )
        BEGIN
            WHILE ( @Month <= 12 )
                BEGIN
				--PROC goes Here
                    SET @Message = 'Working on ' + CAST(@Month AS CHAR(2))
                        + '/' + CAST(@Year AS CHAR(4))
                    RAISERROR(@Message, 0, 1) WITH NOWAIT 
				          
                    SET @LastYearMonth = CAST(@Month AS CHAR(2)) + '/1/'
                        + CAST(@Year - 1 AS CHAR(4))
                    SET @ThisYearMonth = CAST(@Month AS CHAR(2)) + '/1/'
                        + CAST(@Year AS CHAR(4))
                    SET @ThisYearEndMonth = CASE WHEN DATEADD(MONTH, 1,
                                                              @ThisYearMonth) > GETDATE() --THEN GETDATE() - 1
                                                      THEN --DATEADD(DAY, -1,
                                                      CAST(CAST(MONTH(GETDATE()) AS VARCHAR(2))
                                                      + '/'
                                                      + CAST(DAY(GETDATE()) AS VARCHAR(2))
                                                      + '/'
                                                      + CAST(YEAR(GETDATE()) AS CHAR(4)) AS DATETIME)
															  --)
                                                 ELSE DATEADD(MONTH, 1,
                                                              @ThisYearMonth)
                                            END 
                    SET @LastYearEndMonth = CASE WHEN DATEADD(MONTH, 1,
                                                              @ThisYearMonth) > GETDATE()
                                                 THEN DATEADD(DAY,
                                                              DAY(GETDATE()
                                                              - 1),
                                                              @LastYearMonth)
                                                 ELSE DATEADD(MONTH, 1,
                                                              @LastYearMonth)
                                            END  

 
 --SELECT @ThisYearEndMonth AS ThisYearEndMonth,
 --        @LastYearEndMonth AS LastYearEndMonth        
 
 -- 13 MONTH copmop chaange\
 --SET @CompDate = @ThisYearMonth

                    SET @LastYearMontha = DATEADD(HOUR, -13, @LastYearMonth)
                    SET @ThisYearMontha = DATEADD(HOUR, -13, @ThisYearMonth)
                    SET @LastYearEndMontha = DATEADD(HOUR, -13,
                                                     @LastYearEndMonth)
                    SET @ThisYearEndMontha = DATEADD(HOUR, -13,
                                                     @ThisYearEndMonth);

                    WITH    Centers
                              AS ( SELECT   Store.StoreFact.CenterKey ,
                                            Store.StoreFact.ZW_Franchise_ID ,
                                            Store.StoreFact.StoreNumber ,
                                            Store.StoreFact.OpenStatus ,
                                            Store.CountryDim.CountryName AS CountryName ,
                                            Store.CountryDim.CountryCode ,
                                            Store.StoreFact.StoreOpenDate ,
                                            System.StoreControl.DataSource ,
                                            System.StoreControl.AsOfDate
                                   FROM     Store.StoreFact WITH ( NOLOCK )
                                            INNER JOIN Store.CountryDim WITH ( NOLOCK ) ON Store.StoreFact.CountryKey = Store.CountryDim.CountryKey
                                            LEFT JOIN System.StoreControl WITH ( NOLOCK ) ON Store.StoreFact.ZW_Franchise_ID = System.StoreControl.ZW_Franchise_ID
                                            INNER JOIN tmpMissingTemp LastGLTransaction
                                            WITH ( NOLOCK ) ON LastGLTransaction.ZW_Franchise_ID = Store.StoreFact.ZW_Franchise_ID
                                                              AND Last_TransactionDateTime > @MissingDate
                                   WHERE    Store.StoreFact.OpenStatus = 'Open'
                                            AND Store.StoreFact.CompStart <= @LastYearMonth
                                            AND Store.CountryDim.CountryCode = @Country
                                            AND ISNULL(Store.StoreFact.ExcludeFromPickedUP,
                                                       0) <> 1
                                 )
                        SELECT  Centers.CountryCode ,
                                Centers.StoreNumber ,
                                Centers.ZW_Franchise_ID ,
                                ISNULL(Centers.DataSource, 'FSI') AS DataSource ,
                                Sum13.Amount AS [13PickedUP] ,
                                Sum13.Invoices AS [13Inv] ,
                                Sum14.Amount AS [14PickedUP] ,
                                Sum14.Invoices AS [14Inv]
                        INTO    #Temp
                        FROM    Centers
                                INNER JOIN ( SELECT GLFact.ZW_Franchise_ID ,
                                                    SUM(GLFact.Amount) AS Amount ,
                                                    COUNT(DISTINCT OrderID) AS Invoices
                                             FROM   tempGL GLFact WITH ( NOLOCK )
                                        --JOIN Centers ON GLFact.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                             WHERE  GLFact.TransactionDateTime >= @LastYearMonth
                                                    AND GLFact.TransactionDateTime < @LastYearEndMonth
                                             GROUP BY GLFact.ZW_Franchise_ID
                                           ) Sum13 ON Sum13.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                INNER JOIN ( SELECT GLFact.ZW_Franchise_ID ,
                                                    SUM(GLFact.Amount) AS Amount ,
                                                    COUNT(DISTINCT OrderID) AS Invoices
                                             FROM   tempGL GLFact WITH ( NOLOCK )
                                       -- JOIN Centers ON GLFact.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                             WHERE  GLFact.TransactionDateTime >= @ThisYearMonth
                                                    AND GLFact.TransactionDateTime < @ThisYearEndMonth
                                             GROUP BY GLFact.ZW_Franchise_ID
                                           ) Sum14 ON Sum14.ZW_Franchise_ID = Centers.ZW_Franchise_ID



                    IF ( @FirstRun = 1 )
                        BEGIN
                            SELECT  @Month AS intMonth ,
                                    @Year AS EndYear ,
                                    CountryCode ,
                                    StoreNumber ,
                                    ZW_Franchise_ID ,
                                    [13PickedUP] AS LastYear ,
                                    [14PickedUP] AS ThisYear ,
                                    [13Inv] ,
                                    [14Inv]
                            INTO    #Loader
                            FROM    #Temp
                            SET @FirstRun = 0
                        END	
                    ELSE
                        INSERT  INTO #Loader
                                SELECT  @Month AS intMonth ,
                                        @Year AS EndYear ,
                                        CountryCode ,
                                        StoreNumber ,
                                        ZW_Franchise_ID ,
   --                             ISNULL(DataSource, 'FSI') AS DataSource ,
                                        [13PickedUP] AS LastYear ,
                                        [14PickedUP] AS ThisYear ,
                                        [13Inv] ,
                                        [14Inv]
                                FROM    #Temp;

                    DROP TABLE #Temp
                    SET @Month = @Month + 1
                END
            SET @Year = @Year + 1
            SET @Month = 1
        END

    SELECT  loader.EndYear ,
            loader.intMonth ,
            loader.CountryCode ,
            SUM(loader.[13Inv]) AS Invoices_LastYear ,
            SUM(loader.[14Inv]) AS Invoices_ThisYear ,
            SUM(loader.LastYear) / SUM(loader.[13Inv]) AS AVEInvLastYear ,
            SUM(loader.ThisYear) / SUM(loader.[14Inv]) AS AVEInvThisYear ,
            ( ( SUM(loader.ThisYear)
                / CASE WHEN SUM(loader.[14Inv]) = 0 THEN 1
                       ELSE SUM(loader.[14Inv])
                  END ) / ( CASE WHEN SUM(loader.LastYear) = 0 THEN 1
                                 ELSE SUM(loader.LastYear)
                            END / CASE WHEN SUM(loader.[13Inv]) = 0 THEN 1
                                       ELSE SUM(loader.[13Inv])
                                  END ) ) - 1 AS AveInvDiff ,
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
              / ( CASE WHEN SUM(loader.LastYear) = 0 THEN 1
                       ELSE SUM(loader.LastYear)
                  END / LastYearWorking.WorkDays ) ) AS AVGSalesDiffPercentage
    INTO    #Loaded
    FROM    #Loader loader
            INNER JOIN ( SELECT YEAR(System.Calendar.dt) AS intYear ,
                                MONTH(System.Calendar.dt) AS intMonth ,
                                COUNT(*) AS WorkDays
                         FROM   System.Calendar
                         WHERE  System.Calendar.IsWorkDay = 1
                     -- Changed to fix a divide by zero error at the begining of a month.
                                AND System.Calendar.dt < GETDATE() - 1
                         GROUP BY YEAR(System.Calendar.dt) ,
                                MONTH(System.Calendar.dt)
                       ) WorkingDaysYTD ON WorkingDaysYTD.intYear = loader.EndYear
                                           AND WorkingDaysYTD.intMonth = loader.intMonth
            INNER JOIN ( SELECT YEAR(System.Calendar.dt) AS intYear ,
                                MONTH(System.Calendar.dt) AS intMonth ,
                                COUNT(*) AS WorkDays
                         FROM   System.Calendar
                         WHERE  System.Calendar.IsWorkDay = 1
                                AND System.Calendar.dt < DATEADD(DAY, -1,
                                                              DATEADD(YEAR, -1,
                                                              GETDATE()))
                         GROUP BY YEAR(System.Calendar.dt) ,
                                MONTH(System.Calendar.dt)
                       ) LastYearWorking ON LastYearWorking.intYear = loader.EndYear
                                            - 1
                                            AND LastYearWorking.intMonth = loader.intMonth
    GROUP BY loader.intMonth ,
            loader.EndYear ,
            loader.CountryCode ,
            LastYearWorking.WorkDays ,
            WorkingDaysYTD.WorkDays
    ORDER BY loader.CountryCode ,
            loader.EndYear ,
            loader.intMonth




/************************************ current year vs prior year ********************************************************/

		
		/* prior year  So EndYear 2013 means 2012 is prior year */
    SELECT  CAST(GETDATE() AS DATE) AS ReportDate ,
            L.EndYear - 1 AS [Year] ,  /* 2013 for 2014 compare */  /* labels are jacked */
            L.intMonth AS [Month] ,
            L.CentersReporting AS StoreCount ,
            L.Sum_LastYear AS [Sales] ,
            L.LastYearWorkingDays AS BusinessDays ,
            L.AVGBusinessDaySalesLastYear AS AVGBusinessDaySales ,
            0.000000 AS AVGBusinessDaySalesDiff ,
            0.000000 AS SalesDiffPercentage ,
            ISNULL(Counts.CompCenters, 0) AS CompCenters ,
            AVEInvLastYear AS AveInv ,
            0.0000 AS AveInvDiff
    FROM    #Loaded L
            LEFT JOIN System.CompCenterCounts Counts ON Counts.Country = @Country
                                                        AND Counts.Year = L.EndYear
                                                        AND Counts.Month = L.intMonth
    WHERE   L.EndYear = @ReportYear --YEAR(GETDATE()) 
    UNION
    	/* current year compares to prior year  */
    SELECT  CAST(GETDATE() AS DATE) AS ReportDate ,
            L.EndYear AS [Year] ,
            L.intMonth AS [Month] ,
            L.CentersReporting AS StoreCount ,
            L.Sum_ThisYear AS [Sales] ,
            L.ThisYearWorkingDays AS BusinessDays ,
            L.AVGBusinessDaySalesThisYear AS AVGBusinessDaySales ,
            L.AVGBusinessDaySalesDiff AS AVGBusinessDaySalesDiff ,
            L.AVGSalesDiffPercentage AS SalesDiffPercentage ,
            ISNULL(Counts.CompCenters, 0) AS CompCenters ,
            AVEInvThisYear AS AveInv ,
            L.AveInvDiff AS AveInvDiff
    FROM    #Loaded L
            LEFT JOIN System.CompCenterCounts Counts ON Counts.Country = @Country
                                                        AND Counts.Year = L.EndYear
                                                        AND Counts.Month = L.intMonth
    WHERE   L.EndYear = @ReportYear
    UNION
	/* prior year totals */
    SELECT  CAST(GETDATE() AS DATE) AS ReportDate ,
            L.EndYear - 1 AS [Year] ,
            13 AS [Month] ,
            NULL AS StoreCount ,
            SUM(L.Sum_LastYear) AS [Sales] ,
            SUM(L.LastYearWorkingDays) AS BusinessDays ,
            SUM(L.Sum_LastYear) / SUM(L.LastYearWorkingDays) AS AVGBusinessDaySales ,
            0.000000 AS AVGBusinessDaySalesDiff ,
            0.000000 AS SalesDiffPercentage ,
            0 ,
            SUM(L.Sum_LastYear) / SUM(Invoices_LastYear) ,
            0.0000
    FROM    #Loaded L
    WHERE   L.EndYear = @ReportYear
    GROUP BY L.EndYear
    UNION
	/* current year totals */
    SELECT  CAST(GETDATE() AS DATE) AS ReportDate ,
            L.EndYear AS [Year] ,
            13 AS [Month] ,
            NULL AS StoreCount ,
            SUM(L.Sum_ThisYear) AS [Sales] ,
            SUM(L.ThisYearWorkingDays) AS BusinessDays ,
            SUM(L.Sum_ThisYear) / SUM(L.ThisYearWorkingDays) AS AVGBusinessDaySales ,
            SUM(L.Sum_ThisYear) / SUM(L.ThisYearWorkingDays)
            - SUM(L.Sum_LastYear) / SUM(L.LastYearWorkingDays) AS AVGBusinessDaySalesDiff ,
            ( SUM(L.Sum_ThisYear) / SUM(L.ThisYearWorkingDays)
              - SUM(L.Sum_LastYear) / SUM(L.LastYearWorkingDays) )
            / ( SUM(L.Sum_LastYear) / SUM(L.LastYearWorkingDays) ) AS SalesDiffPercentage ,
            0 ,
            SUM(L.Sum_ThisYear) / SUM(Invoices_ThisYear) ,
            0
    FROM    #Loaded L
    WHERE   L.EndYear = @ReportYear
    GROUP BY L.EndYear
		
--DROP TABLE #Loaded;
--DROP TABLE #Loader;


GO
