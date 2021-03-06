/****** Object:  StoredProcedure [dbo].[rpt_RPM_Records_Chart]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Tim Fleck
-- Create date: 9/13/2013
-- Description:	for RPM Records Chart Report
-- =============================================
CREATE PROCEDURE [dbo].[rpt_RPM_Records_Chart]
    (
      @Center CHAR(7) ,
      @BeginDate DATETIME ,
      @EndDate DATETIME
    )
AS 
    BEGIN
        SELECT
            zw_franchise_id ,
            sys_du ,
            SalesSubtotal
        INTO
            #Orders
        FROM
            [Order Database]
        WHERE
            zw_franchise_id = @Center
            AND [Order Database].sys_du >= @BeginDate
            AND [Order Database].sys_du < @EndDate 

        SELECT
            @Center AS zw_franchise_id ,
            DateDim.*
        INTO
            #Dates
        FROM
            DateDim
        WHERE
            PK_Date >= @BeginDate
            AND PK_Date < @EndDate

        SELECT
            #Dates.zw_franchise_id ,
            PK_Date ,
            SUM(SalesSubtotal) AS Sales ,
            COUNT(*) AS Records
        INTO
            #Reports
        FROM
            #Dates WITH ( NOLOCK )
            LEFT JOIN #Orders WITH ( NOLOCK ) ON ( CAST(CONVERT([Char](10), #Orders.sys_du, 101) AS DATETIME) ) = #Dates.PK_Date
        GROUP BY
            #Dates.zw_franchise_id ,
            PK_Date

        SELECT
            zw_franchise_id ,
            CONVERT(CHAR(10), PK_date, 101) AS ProcessDate ,
            DATENAME(dw, pk_date) ,
	--DATEPART(dw,pk_date),
            ISNULL(Sales, 0) AS Sales ,
            CASE WHEN Sales IS NULL THEN Records - 1
                 ELSE Records
            END AS Records
        FROM
            #Reports
        WHERE
            DATEPART(dw, pk_date) > 1
            AND DATEPART(dw, pk_date) < 7

        DROP TABLE #Dates
        DROP TABLE #Orders
        DROP TABLE #Reports
    END

GO
