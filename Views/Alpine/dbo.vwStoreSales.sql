/****** Object:  View [dbo].[vwStoreSales]    Script Date: 5/15/2018 12:13:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE VIEW [dbo].[vwStoreSales]
AS
SELECT  srr.RoyaltyReportID AS id
      , cs.StoreNumber
      , cs.WebNumber
	  , cs.StoreType
      , ( SELECT TOP ( 1 )
                    cp.FirstName + ' ' + cp.LastName AS Expr1
          FROM      dbo.COR_STORES_PERSONS_LINK AS cs2
                    INNER JOIN dbo.COR_STORES AS css ON cs2.StoreID = css.StoreID
                    INNER JOIN dbo.COR_PERSONS AS cp ON cs2.PersonID = cp.PersonID
          WHERE     ( css.StoreNumber = cs.StoreNumber )
                    AND ( cp.PersonType = 2001 )
                    AND ( cs2.GoldMinePlacement = 0 )
        ) AS Owner
      , cs.WebsiteUrl
      , cs.Alert
      , cs.LimitedServices
      , cs.COD
      , cs.Operational
      , cs.Pacesetter
      , srp.EndDate
      , srr.TotalSales
      , srr.OperatingMonth
      , CONVERT(VARCHAR(30), cs.StoreOpenDate, 101) AS StoreOpenDate
      , DATEPART(Year, cs.StoreOpenDate) AS StoreOpenByYear
      , CONVERT(VARCHAR(30), ( SELECT  MAX(begindate)
                               FROM     dbo.COR_STORE_DATES
                               WHERE    ( dbo.COR_STORE_DATES.StoreID=cs.Storeid )
                                        AND ( beginStatus = 3004 )
                             ), 101) AS StoreResaleDate
      , cs.VanityName 
      , cpd.ShortName
      , ca.City
FROM    dbo.SLS_ROYALTY_REPORT AS srr
        INNER JOIN dbo.SLS_ROYALTY_PERIOD AS srp ON srr.RoyaltyPeriodID = srp.RoyaltyPeriodID
        INNER JOIN dbo.COR_STORES AS cs ON srp.StoreID = cs.StoreID
        INNER JOIN dbo.COR_STORES_ADDRESSES_LINK AS csal ON cs.StoreID = csal.StoreID
        INNER JOIN dbo.COR_ADDRESSES AS ca ON csal.AddressID = ca.AddressID
        INNER JOIN dbo.COR_POLITICAL_DIVISION AS cpd ON cpd.PoliticalDivisionID = ca.PoliticalDivisionID
WHERE   ( srp.EndDate > '1/1/1988' )




GO
