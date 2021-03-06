/****** Object:  StoredProcedure [dbo].[select_Top10MultiCenterSales]    Script Date: 5/15/2018 12:09:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Chris Spain
-- Create date: 8/11/11
-- Description:	Used to get top 10 multi-center sales
-- =============================================

/*************************************************************
DEPLOYMENT DATE:	08/08/2011
DEPLOYER:		Todd Peterson
CHANGESET:		2552
SERVER/DB:		01DALSVMSQL001..ALPINE
COMMENTS:		
*************************************************************/

CREATE PROCEDURE [dbo].[select_Top10MultiCenterSales]
	-- Add the parameters for the stored procedure here
	@month int, 
	@year int
AS
BEGIN

	SET NOCOUNT ON;

;WITH StoreCountCTE (storegroupid,storecount) AS
	(
	 SELECT sg.storegroupid
		,COUNT(sg.storeid) AS storecount
	 FROM cor_stores s WITH(NOLOCK)
			INNER JOIN cor_store_groups sg WITH(NOLOCK)
				ON s.storeid = sg.storeid
			INNER JOIN (SELECT DISTINCT STOREID
							,CAST(DATEPART(YEAR,EndDate) AS VARCHAR) 
								+RIGHT('0' + CONVERT(VARCHAR(2), MONTH(enddate)), 2) + '01'
							 AS EndDate
						FROM SLS_ROYALTY_PERIOD) AS srp
				ON s.StoreID = srp.StoreID
     WHERE sg.StoreGroupID = sg.StoreGroupID
          AND SUBSTRING(srp.EndDate,5,2) = @month   
		  AND LEFT(srp.EndDate,4) = @year
	 GROUP BY sg.storegroupid		
	 HAVING COUNT(sg.storeid) > 1
	 )

SELECT TOP 10 
	csg.StoreGroupID
	,(  
	  SELECT TOP 1 cs2.VanityName  
	  FROM cor_stores cs2 WITH(NOLOCK)  
				INNER JOIN cor_store_groups csg2 WITH(NOLOCK) 
					ON cs2.StoreId = csg2.StoreId  
      WHERE csg.StoreGroupID = csg2.StoreGroupID
      ) 
							AS VanityName
	,scCTE.storecount		AS storeCount
	,SUM(srr.TotalSales)	AS Total   
FROM cor_store_groups csg 
		INNER JOIN StoreCountCTE scCTE WITH(NOLOCK)
			ON csg.storegroupid = scCTE.storegroupid
		INNER JOIN cor_stores cs WITH(NOLOCK) 
			ON cs.StoreId = csg.StoreId 
		INNER JOIN SLS_ROYALTY_PERIOD AS srp WITH(NOLOCK) 
			ON cs.StoreID = srp.StoreID   
		INNER JOIN SLS_ROYALTY_REPORT AS srr WITH(NOLOCK) 
			ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID 
		INNER JOIN COR_STORES_ADDRESSES_LINK AS cral WITH(NOLOCK) 
			ON cs.storeid = cral.storeid     
		INNER JOIN COR_ADDRESSES ca WITH(NOLOCK) 
			ON cral.addressid = ca.addressid    
		INNER JOIN COR_POLITICAL_DIVISION cpd WITH(NOLOCK) 
			ON ca.politicaldivisionid = cpd.politicaldivisionid  
		INNER JOIN COR_COUNTRIES cc WITH(NOLOCK) 
			ON cpd.Countryid = cc.countryid     
		INNER JOIN COR_INTERNATIONAL_REGIONS cr WITH(NOLOCK) 
			ON cc.internationalregionid = cr.internationalregionid  
WHERE cs.Reportable					= 1 
  AND DATEPART(MONTH,srp.EndDate)	= @month   
  AND DATEPART(YEAR,srp.EndDate)	= @year    
  AND cr.fullname					= 'USA' 
GROUP BY csg.StoreGroupID 
    ,scCTE.storecount
ORDER BY Total DESC
END


GO
