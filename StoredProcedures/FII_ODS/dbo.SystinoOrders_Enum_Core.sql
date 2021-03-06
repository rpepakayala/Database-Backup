/****** Object:  StoredProcedure [dbo].[SystinoOrders_Enum_Core]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[SystinoOrders_Enum_Core]
    @GPickedUpDate2 DATETIME ,
    @LPickedUpDate2 DATETIME
AS --DECLARE
	--	@GPickedUpDate2 DATETIME ,
	--	@LPickedUpDate2 DATETIME
	SET @GPickedUpDate2 = @GPickedUpDate2 - 30
	--SET @LPickedUpDate2 = GETDATE() - 3  

    SELECT DISTINCT TOP 200
            Driver.CorebridgeOrder AS OrderID ,
            vw_Store.StoreNumber AS StoreID ,
            vw_Store.StoreNumber AS StoreNumber ,
            100 AS PricingRatio ,
            'Products' AS OrderDescription ,
            'PickedUp' AS Status ,
            0 AS NumberItems ,
            CoreBridgeCentral.dbo.AccountConsolidated.AccountId AS CustomerID ,
            CoreBridgeCentral.dbo.OrderConsolidated.OrderContactId AS ContactID ,
            CoreBridgeCentral.dbo.ContactConsolidated.FirstName AS OrdererFirstName ,
            CoreBridgeCentral.dbo.ContactConsolidated.LastName AS OrdererLastName ,
            CoreBridgeCentral.dbo.ContactConsolidated.Title AS OrdererTitle ,
            '' AS OrdererPareaCode ,
            CoreBridgeCentral.dbo.ContactConsolidated.PrimaryPhoneNumber AS OrdererPhoneNumber ,
            CoreBridgeCentral.dbo.ContactConsolidated.PrimaryPhoneNumberExtension AS OrdererPhoneExtention ,
            '' AS OrdererFareaCode ,
            '' AS OrdererFaxNumber ,
            CoreBridgeCentral.dbo.ContactConsolidated.EmailAddress AS OrdererEmailAddress ,
            0 AS OrderOriginID ,
            0.00 AS InterestAmount ,
            Driver.NewSubtotal AS SalesTotal ,
            CoreBridgeCentral.dbo.CompaniesLocations.ZW_Franchise_ID ,
            CoreBridgeCentral.dbo.ContactConsolidated.EmailAddress AS OrdererEmailAddress1 ,
            Driver.OrderCompletionDate AS PickedUpDate ,
            Driver.BillingAddress1 ,
            Driver.BillingAddress2 ,
            Driver.BillingCity AS City ,
            Driver.BillingState AS State ,
            Driver.BillingZip AS Zip ,
            Driver.CompanyName AS CompanyName ,
            vw_Store.CountryName AS Country ,
            vw_Store.StoreOpenDate AS StoreOpenDate ,
            vw_Store.RegionName AS SalesRegionName ,
            vw_Store.CountryCode AS CountryCode
    FROM    ( SELECT
	orderID,
	CompanyLocationId,
  vw_Locations.ZW_Franchise_ID,
  SalesResultsAllDispositions.InvoiceNumber AS InvoiceNumber1,
  Max(SalesResultsAllDispositions.OrderCompletionDate) AS OrderCompletionDate,
  Sum(SalesResultsAllDispositions.Amount) AS NewSubtotal,
  Max(SalesResultsAllDispositions.BillingAddress1) AS BillingAddress1,
  Max(SalesResultsAllDispositions.BillingAddress2) AS BillingAddress2,
  Max(SalesResultsAllDispositions.BillingCity) AS BillingCity,
  Max(SalesResultsAllDispositions.BillingState) AS BillingState,
  Max(SalesResultsAllDispositions.BillingZip) AS BillingZip,
  Max(SalesResultsAllDispositions.CompanyName) AS CompanyName,
  Max(Replace(Replace(Replace(Replace(Replace(Replace(SalesResultsAllDispositions.CorebridgeOrder, 'SF-', ''),
  '-V', ''), 'WP-', ''), 'PG-', ''), 'I-', ''), 'B-I-', '')) AS CorebridgeOrder
FROM
  CoreBridgeCentral.dbo.SalesResultsAllDispositions SalesResultsAllDispositions
  INNER JOIN CoreBridgeCentral.dbo.vw_Locations  vw_Locations ON SalesResultsAllDispositions.CompanyLocationId = vw_Locations.Value
WHERE
  SalesResultsAllDispositions.OrderCompletionDate > @GPickedUpDate2 AND
  OrderCompletionDate < @LPickedUpDate2
GROUP BY
  CompanyLocationId,
  orderID,
  vw_Locations.ZW_Franchise_ID,
  SalesResultsAllDispositions.InvoiceNumber

        
            ) Driver
            INNER JOIN CoreBridgeCentral.dbo.ContactConsolidated ON Driver.CompanyLocationId = CoreBridgeCentral.dbo.ContactConsolidated.CompanyLocationId
                                                              AND CoreBridgeCentral.dbo.ContactConsolidated.EmailAddress IS NOT NULL
            INNER JOIN CoreBridgeCentral.dbo.OrderConsolidated ON CoreBridgeCentral.dbo.OrderConsolidated.CompanyLocationId = Driver.CompanyLocationId
                                                              AND CoreBridgeCentral.dbo.OrderConsolidated.OrderId = Driver.OrderId
                                                              AND CoreBridgeCentral.dbo.OrderConsolidated.OrderContactId = CoreBridgeCentral.dbo.ContactConsolidated.ContactId
            INNER JOIN CoreBridgeCentral.dbo.CompaniesLocations ON Driver.CompanyLocationId = CoreBridgeCentral.dbo.CompaniesLocations.Value
            INNER JOIN CoreBridgeCentral.dbo.AccountConsolidated ON CoreBridgeCentral.dbo.ContactConsolidated.AccountId = CoreBridgeCentral.dbo.AccountConsolidated.AccountId
                                                              AND CoreBridgeCentral.dbo.ContactConsolidated.CompanyLocationId = CoreBridgeCentral.dbo.AccountConsolidated.CompanyLocationId
            INNER JOIN vw_Store WITH ( NOLOCK ) ON Driver.ZW_Franchise_ID = vw_Store.ZW_Franchise_ID
            LEFT JOIN System.SystinoSubmittedOrders sso WITH ( NOLOCK ) ON Driver.CorebridgeOrder = sso.OrderID
                                                              AND Driver.ZW_Franchise_ID = sso.FranchiseID
    WHERE   CoreBridgeCentral.dbo.CompaniesLocations.ZW_Franchise_ID NOT IN (
            'FSI000' )
			--AND CoreBridgeCentral.dbo.CompaniesLocations.ZW_Franchise_ID IN ('FSI2024','FSI2093')
            AND sso.Submitted IS NULL 
	  --7/18/2016 new business rule, only orders over $150 get surveys
            AND Driver.NewSubtotal > 150
    OPTION  ( OPTIMIZE FOR ( @gpickedupdate2 UNKNOWN,@lpickedupdate2 UNKNOWN ) )
	
	--GRANT EXECUTE ON dbo.SystinoOrders_Enum_Core to [FASTSIGNS\app_systino_prod] 
GO
