/****** Object:  StoredProcedure [dbo].[usp_Excel_Demo]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE usp_Excel_Demo
	@Franchise_ID CHAR(7) 

AS
BEGIN
CREATE TABLE #WeeklyOrdersPlaced
    (
      [Center] VARCHAR(7) ,
      OrderAmt MONEY ,
      [YearWeek] CHAR(7) ,
      [Week_Start] DATETIME
    )

CREATE TABLE #WeeklyOrdersPickedUp
    (
      [Center] VARCHAR(7) ,
      SalesTotal MONEY ,
      [YearWeek] CHAR(7) ,
      [Week_Start] DATETIME
    )


INSERT  INTO #WeeklyOrdersPlaced
        SELECT
            MAX(oh.[ZW_Franchise_ID]) AS [ZW_Franchise_ID] ,
            SUM(oh.[SalesSubtotal]) AS OrderAmt ,
            STR(DATEPART(yy, oh.[OrderDate]), 4) + '-' + STR(DATEPART(wk,
                                                              oh.[OrderDate]),
                                                             2) AS 'YearWeek' ,
            MAX(DATEADD(DAY, -( DATEPART(dw, oh.[OrderDate]) - 2 ),
                        oh.[OrderDate])) AS week_start
        FROM
            [Orders].[OrderHeaderFact] OH
        WHERE
            OH.[ZW_Franchise_ID] = @Franchise_ID
            AND ( oh.[OrderDate] >= '07/01/2012' )
        GROUP BY
            STR(DATEPART(yy, oh.[OrderDate]), 4) + '-' + STR(DATEPART(wk,
                                                              oh.[OrderDate]),
                                                             2)


INSERT  INTO #WeeklyOrdersPickedUp
        SELECT
            MAX(oh.[ZW_Franchise_ID]) AS [ZW_Franchise_ID] ,
            SUM(oh.[SalesSubtotal]) AS SaleAmt ,
            STR(DATEPART(yy, oh.PickedUpDate), 4) + '-' + STR(DATEPART(wk,
                                                              oh.PickedUpDate),
                                                              2) AS 'YearWeek' ,
            MAX(DATEADD(DAY, -( DATEPART(dw, oh.PickedUpDate) - 2 ),
                        oh.PickedUpDate)) AS week_start
        FROM
            [Orders].[OrderHeaderFact] OH
        WHERE
            OH.[ZW_Franchise_ID] = @Franchise_ID
            AND ( oh.PickedUpDate >= '07/01/2012' )
        GROUP BY
            STR(DATEPART(yy, oh.PickedUpDate), 4) + '-' + STR(DATEPART(wk,
                                                              oh.PickedUpDate),
                                                              2)
  
    

SELECT  -- A.Center ,
    A.YearWeek ,
						--  A.Week_Start,
    OrderAmt ,
    SalesTotal
FROM
    #WeeklyOrdersPlaced A
    JOIN #WeeklyOrdersPickedUp B ON A.YearWeek = B.YearWeek
 
 
DROP TABLE #WeeklyOrdersPlaced
DROP TABLE #WeeklyOrdersPickedUp
END

GO
