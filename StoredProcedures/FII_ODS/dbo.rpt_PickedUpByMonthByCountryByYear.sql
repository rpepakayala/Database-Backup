/****** Object:  StoredProcedure [dbo].[rpt_PickedUpByMonthByCountryByYear]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[rpt_PickedUpByMonthByCountryByYear] 
    (
     @Month INT = NULL
     ,@Year INT = NULL
     ,@Country VARCHAR(2) = 'US'
    )
AS
    SET NOCOUNT ON		
	

--DECLARE @Month INT = 11
--DECLARE @Year INT = 2014
--DECLARE @country CHAR(2) ='US'

    IF @Month IS NULL
        BEGIN    
            SET @Month = MONTH(GETDATE())
        END;

    IF @Year IS NULL
        BEGIN    
            SET @Year = YEAR(GETDATE())
        END;



DECLARE @BegMonthLASTYear DATETIME 
SET @BegMonthLASTYear=CAST(@Month AS CHAR(2))+'/1/'+CAST(@Year-1 AS CHAR(4)) 
DECLARE @BegMonthTHISYear DATETIME 
SET @BegMonthTHISYear=CAST(@Month AS CHAR(2))+'/1/'+CAST(@Year AS CHAR(4))
DECLARE @EndMonthLASTYear DATETIME 
SET @EndMonthLASTYear=DATEADD(MONTH,1,@BegMonthLASTYear)
DECLARE @EndMonthTHISYear DATETIME 
SET @EndMonthTHISYear=DATEADD(MONTH,1,@BegMonthTHISYear);


DECLARE @BegMonthLASTYearA DATETIME 
SET @BegMonthLASTYearA= DATEADD(HOUR,-13,@BegMonthLASTYear)
DECLARE @BegMonthTHISYearA DATETIME 
SET @BegMonthTHISYeara= DATEADD(HOUR,-13,@BegMonthTHISYear)
DECLARE @EndMonthLASTYearA DATETIME 
SET @EndMonthLASTYearA= DATEADD(HOUR,-13,@EndMonthLASTYear)
DECLARE @EndMonthTHISYearA DATETIME 
SET @EndMonthTHISYearA= DATEADD(HOUR,-13,@EndMonthTHISYear);



WITH    Centers
          AS ( SELECT
                Store.StoreFact.CenterKey ,
                Store.StoreFact.ZW_Franchise_ID ,
                Store.StoreFact.StoreNumber ,
                Store.StoreFact.OpenStatus ,
                Store.CountryDim.CountryName ,
                Store.CountryDim.CountryCode ,
                Store.StoreFact.StoreOpenDate ,
                [System].ZipCode.city ,
                [System].ZipCode.[state] ,
                [System].ZipCode.timezone ,
                [System].ZipCode.dst ,
                [System].ZipCode.zip ,
                [System].StoreControl.DataSource ,
                [System].StoreControl.AsOfDate
               FROM
                Store.StoreFact
                INNER JOIN Store.CountryDim ON Store.StoreFact.CountryKey = Store.CountryDim.CountryKey
                LEFT JOIN [System].ZipCode ON Store.StoreFact.Zip = [System].ZipCode.zip
                LEFT JOIN [System].StoreControl ON Store.StoreFact.ZW_Franchise_ID = [System].StoreControl.ZW_Franchise_ID
               WHERE
                Store.StoreFact.OpenStatus = 'Open'
                AND Store.StoreFact.StoreOpenDate < @BegMonthLASTYear 
				AND Store.CountryDim.CountryCode=@country
             )
    SELECT
        Centers.StoreNumber ,
        Centers.ZW_Franchise_ID ,
        Centers.DataSource ,
        SumLASTYear.Amount AS PickedUpLASTYear ,
        SumTHISYear.Amount AS PickedUpTHISYear ,
		SumTHISYear.Amount - SumLASTYear.Amount  AS YearDifference
	INTO #Temp
    FROM
        Centers
        INNER JOIN ( SELECT
                        GL.GLFact.ZW_Franchise_ID ,
                        SUM(GL.GLFact.Amount * -1) AS Amount
                     FROM
                        GL.GLFact
						JOIN Centers ON GLFact.CenterKey = Centers.CenterKey
                     WHERE
                        GL.GLFact.AccountCode IN  (4001,4002,4003,4110,4120)
                        AND GL.GLFact.TransactionDateTime >= CASE WHEN Centers.DataSource = 'KEY' 
						THEN @BegMonthLASTYear ELSE @BegMonthLASTYearA END 
                        AND GL.GLFact.TransactionDateTime < CASE WHEN Centers.DataSource = 'KEY' 
						THEN @EndMonthLASTYear ELSE @EndMonthLASTYearA  END
                     GROUP BY
                        GL.GLFact.ZW_Franchise_ID
                   ) SumLASTYear ON SumLASTYear.ZW_Franchise_ID = Centers.ZW_Franchise_ID
        INNER JOIN ( SELECT
                        GL.GLFact.ZW_Franchise_ID ,
                        SUM(GL.GLFact.Amount * -1) AS Amount
                     FROM
                        GL.GLFact
						JOIN Centers ON GLFact.CenterKey = Centers.CenterKey
                     WHERE
                        GL.GLFact.AccountCode IN  (4001,4002,4003,4110,4120)
                        AND GL.GLFact.TransactionDateTime >= CASE WHEN Centers.DataSource = 'KEY' 
						THEN @BegMonthTHISYear ELSE @BegMonthTHISYearA  END 
                        AND GL.GLFact.TransactionDateTime < CASE WHEN Centers.DataSource = 'KEY' 
						THEN @EndMonthTHISYear ELSE @EndMonthTHISYearA  END 
                     GROUP BY
                        GL.GLFact.ZW_Franchise_ID
                   ) SumTHISYear ON SumTHISYear.ZW_Franchise_ID = Centers.ZW_Franchise_ID

    SELECT     StoreNumber ,
        ZW_Franchise_ID ,
        ISNULL(DataSource,'FSI') AS DataSource,
        PickedUpLASTYear ,
        PickedUpTHISYear ,
		YearDifference
	FROM #Temp
	WHERE PickedUpLASTYear > 0.00 AND PickedUpTHISYear > 0.00; /* ensure sales in both years */

--DROP TABLE #Temp;

GO
