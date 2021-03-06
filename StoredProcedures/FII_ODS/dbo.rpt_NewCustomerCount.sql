/****** Object:  StoredProcedure [dbo].[rpt_NewCustomerCount]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[rpt_NewCustomerCount]
    (
      @CountryName VARCHAR(50) = 'USA'
    , @FranchiseID VARCHAR(7) = NULL
    , @CenterKey INT = NULL
    , @StartDate DATETIME = NULL
    , @EndDate DATETIME = NULL
    )
AS 
    SET NOCOUNT ON
					
    IF @CountryName IS NULL 
        BEGIN	    
            SET @CountryName = 'USA'
        END
    	
    IF @StartDate IS NULL 
        BEGIN	    
            SET @StartDate = DATEADD(yy, -1, GETDATE())
        END
    
    IF @EndDate IS NULL 
        BEGIN	    
            SET @EndDate = DATEADD(dd, -1, GETDATE())
        END
 	 								  

    SELECT  S.StoreNumber AS StoreNumber
          , o.[ZW_Franchise_ID] AS WebNumber
          , LEFT(CONVERT(VARCHAR, cf.firstorderdate, 112), 6) AS FirstOrderDate
          , COUNT(DISTINCT cf.customerkey) AS 'NewCustomerCount'
    FROM    [FII_ODS].[Orders].[OrderHeaderFact] O
            JOIN [FII_ODS].Store.StoreFact S ON O.CenterKey = S.CenterKey
            JOIN [FII_ODS].Store.CountryDim C ON S.CountryKey = C.CountryKey
            JOIN [FII_ODS].Contact.CustomerFact CF ON CF.CustomerKey = O.CustomerKey
            JOIN [FII_ODS].Store.OperationalDim OP ON S.OperationalKey = OP.OperationalKey
    WHERE   c.CountryName = @CountryName
            AND op.OperationalName <> 'Closed'
            AND cf.firstorderdate BETWEEN @StartDate AND @EndDate
            AND 1 = CASE WHEN ( @CenterKey IS NULL ) THEN 1
                         ELSE CASE WHEN ( s.CenterKey = @CenterKey ) THEN 1
                                   ELSE 0
                              END
                    END
    GROUP BY S.StoreNumber
          , o.[ZW_Franchise_ID]
          , LEFT(CONVERT(VARCHAR, cf.firstorderdate, 112), 6)
    ORDER BY 1
          , 2	 
		


GO
