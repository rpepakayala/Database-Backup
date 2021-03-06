/****** Object:  UserDefinedFunction [dbo].[fn_InPickedUp]    Script Date: 5/15/2018 12:14:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
--EXEC [dbo].[usp_PickedUpAVG] 'US',9,2016


CREATE FUNCTION [dbo].[fn_InPickedUp]
    (
      @Country VARCHAR(2)  ,
      @Month INT  ,
      @Year INT
    )
RETURNS @PickedUP TABLE 
(
StoreNumber INT,ZW_Franchise_ID CHAR(7),LastYear FLOAT,ThisYear FLOAT --,LastYearAveInv FLOAT,ThisYearAveInv FLOAT	
)
AS 
-- Returns the Details for the PickedUP report COMP calc. Can be used to see if a Center is on the Picked Up report.
BEGIN 
--DECLARE @country CHAR(2) = 'US'

DECLARE @ReportDate DATE 

DECLARE @MissingDays INT
SET @MissingDays = 0


DECLARE @MissingDate DATE

--DECLARE @Month INT
--DECLARE @Year INT

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


SET @ReportDate = GETDATE()

SET @ReportDate = CAST(CAST(MONTH(@ReportDate) AS VARCHAR(2)) + '/'
    + CAST(DAY(@ReportDate) AS VARCHAR(2)) + '/'
    + CAST(YEAR(@ReportDate) AS CHAR(4)) AS DATETIME)


SET @MissingDate = DATEADD(DAY, -1 * @MissingDays, GETDATE())

IF @ReportYear IS NULL
    BEGIN  
        SET @ReportYear = YEAR(@ReportDate)
    END


--SET @Month = 9
--SET @Year = 16



--WHILE ( @Year <= YEAR(GETDATE()) )
    --BEGIN
        --WHILE ( @Month <= 12 )
            --BEGIN
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
                                                          DAY(GETDATE() - 1),
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
                SET @LastYearEndMontha = DATEADD(HOUR, -13, @LastYearEndMonth)
                SET @ThisYearEndMontha = DATEADD(HOUR, -13, @ThisYearEndMonth)


INSERT INTO @PickedUP
                    SELECT
                        --Centers.CountryCode ,
                        Centers.StoreNumber ,
                        Centers.ZW_Franchise_ID ,
                        --ISNULL(Centers.DataSource, 'FSI') AS DataSource ,
                        Sum13.Amount AS [13PickedUP] ,
						--Sum13.Invoices AS [13Inv],
                        Sum14.Amount AS [14PickedUP]--,
						--Sum14.Invoices AS [14Inv]
  --                  INTO
  --                      #Temp
                    FROM
                        ( SELECT
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
                                Store.StoreFact WITH (NOLOCK) 
                                INNER JOIN Store.CountryDim WITH (NOLOCK) ON Store.StoreFact.CountryKey = Store.CountryDim.CountryKey
                                LEFT JOIN System.StoreControl WITH (NOLOCK) ON Store.StoreFact.ZW_Franchise_ID = System.StoreControl.ZW_Franchise_ID
                                --INNER JOIN tmpMissingTemp LastGLTransaction
                                --WITH ( NOLOCK ) ON LastGLTransaction.ZW_Franchise_ID = Store.StoreFact.ZW_Franchise_ID
                                --                   AND Last_TransactionDateTime > @MissingDate
                               WHERE
                                Store.StoreFact.OpenStatus = 'Open'
                                AND Store.StoreFact.CompStart <= @LastYearMonth
                                AND Store.CountryDim.CountryCode = @country
                                AND ISNULL(Store.StoreFact.ExcludeFromPickedUP,
                                           0) <> 1
                             ) Centers
                        JOIN ( SELECT
                                        GLFact.ZW_Franchise_ID ,
                                        SUM(GLFact.Amount) AS Amount,
										Count(DISTINCT OrderID) AS Invoices
                                     FROM
                                        tempGL GLFact WITH ( NOLOCK )
                                        --JOIN Centers ON GLFact.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                     WHERE
                                        GLFact.TransactionDateTime >= @LastYearMonth
                                        AND GLFact.TransactionDateTime < @LastYearEndMonth
                                     GROUP BY
                                        GLFact.ZW_Franchise_ID
                                   ) Sum13 ON Sum13.ZW_Franchise_ID = Centers.ZW_Franchise_ID

                        JOIN ( SELECT
                                        GLFact.ZW_Franchise_ID ,
                                        SUM(GLFact.Amount) AS Amount,
										Count(DISTINCT OrderID) AS Invoices
                                     FROM
                                        tempGL GLFact WITH ( NOLOCK )
                                       -- JOIN Centers ON GLFact.ZW_Franchise_ID = Centers.ZW_Franchise_ID
                                     WHERE
                                        GLFact.TransactionDateTime >= @ThisYearMonth
                                        AND GLFact.TransactionDateTime < @ThisYearEndMonth
                                     GROUP BY
                                        GLFact.ZW_Franchise_ID
                                   ) Sum14 ON Sum14.ZW_Franchise_ID = Centers.ZW_Franchise_ID



--                IF ( @FirstRun = 1 )
--                    BEGIN
--                        SELECT
--                            --@Month AS intMonth ,
--                            --@Year AS EndYear ,
--                            --CountryCode ,
--                            StoreNumber ,
--                            ZW_Franchise_ID ,
--                            [13PickedUP] AS LastYear ,
--                            [14PickedUP] AS ThisYear ,
--							[13Inv] AS LastYearAveInv,
--							[14Inv] AS ThisYearAveInv
--                        INTO
--                            #Loader
--                        FROM
--                            #Temp

--INSERT INTO @PickedUP
--SELECT * FROM #Loader
	
RETURN
END 




GO
