/****** Object:  StoredProcedure [dbo].[rpt_Monthy_KClub]    Script Date: 5/15/2018 12:09:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[rpt_Monthy_KClub]
AS
BEGIN

SET NOCOUNT ON;

DECLARE @SalesYear INT;
DECLARE @SalesMonth INT;
--DECLARE @Country NVARCHAR(30);


SET @SalesYear = DATEPART(YEAR, DATEADD(MONTH, -1, GETDATE()))
SET @SalesMonth = DATEPART(MONTH, DATEADD(m, -1, GETDATE())) 
--SET @Country = 'United States'


SELECT
    DATENAME(MONTH, DATEADD(m, -1, GETDATE())) AS SalesMonth2 ,
    @SalesYear AS SalesYear ,
    DATENAME(MONTH, DATEADD(m, -1, GETDATE())) + '/'
    + CAST(@SalesYear AS CHAR(4)) AS LastMonth ,
    ( SELECT
        SUM(r.TotalSales)
      FROM
        Alpine.dbo.[SLS_ROYALTY_PERIOD] rp
        INNER JOIN Alpine.dbo.[SLS_ROYALTY_REPORT] r ON rp.RoyaltyPeriodID = r.RoyaltyPeriodID
      WHERE
        rp.StoreID = s.StoreID
        AND MONTH(rp.EndDate) = @SalesMonth
        AND YEAR(rp.EndDate) = @SalesYear
    ) AS TotalSales ,
    s.VanityName ,
    s.StoreNumber ,
    k.kClub ,
    a.City ,
    p.ShortName AS State ,
    c.FullName AS Country,
    s.StoreID
FROM
    Alpine.dbo.[SLS_KCLUB] k
    INNER JOIN Alpine.dbo.[COR_STORES] s ON s.StoreID = k.StoreID
    INNER JOIN Alpine.dbo.[COR_STORES_ADDRESSES_LINK] l ON l.StoreID = s.StoreID
    INNER JOIN Alpine.dbo.[COR_ADDRESSES] a ON l.AddressID = a.AddressID
    INNER JOIN Alpine.dbo.[COR_POLITICAL_DIVISION] p ON a.PoliticalDivisionID = p.PoliticalDivisionID
    INNER JOIN Alpine.dbo.[COR_COUNTRIES] c ON p.CountryID = c.CountryID
WHERE
    MONTH(SalesDate) = @SalesMonth
    AND YEAR(SalesDate) = @SalesYear
--  AND c.FullName = @Country
    AND s.Reportable = 1
    AND k.kClub >= 30
ORDER BY
    k.kClub DESC
END


GO
