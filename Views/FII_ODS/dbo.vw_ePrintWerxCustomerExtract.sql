/****** Object:  View [dbo].[vw_ePrintWerxCustomerExtract]    Script Date: 5/15/2018 12:13:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

 CREATE    VIEW  [dbo].[vw_ePrintWerxCustomerExtract]    AS

SELECT 
      '' AS AddressID
      , '' AS CityStateKey
      , '' AS RecordTypeCode
      , Contact.CountryDim.CountryCode
      , '' AS StateCode
      , Contact.CustomerFact.[State] AS StateAbbr
      , '' AS CountyCode
      , Contact.CountyDim.CountyName
      , Contact.ZipDim.ZipName AS ZipCode
      , '' AS Zip4
      , '' AS CarrierRouteID
      , '' AS DeliveryPoint
      , '' AS CityNameAbbr
      , Contact.CustomerFact.City AS CityName
      , '' AS AddressPrimaryNo
      , '' AS BuildingOrFirmName
      , '' AS StreetPreDirection
      , '' AS StreetName
      , '' AS StreetSuffix
      , '' AS StreetPostDirection
      , '' AS AddresSecondaryAbbr
      , '' AS AddressSecondaryNo
      , Contact.CustomerFact.BillingAddress1 AS FullAddressLine1
      , COALESCE(Contact.CustomerFact.BillingAddress2,'') AS FullAddressLine2
      , '' AS CBSA
      , '' AS CBSAType
      , '' AS CensusTract
      , '' AS CensusBlock
      , '' AS Latitude
      , '' AS Longitude
      , Contact.ContactFact.FirstName
      , '' AS Initial
      , Contact.ContactFact.LastName
      , '' AS NamePrefix
      , '' AS NameSuffix
      , COALESCE(Contact.ContactFact.FirstName, '') + ' '  + COALESCE(Contact.ContactFact.LastName, '') AS FullName
      , COALESCE(Contact.ContactFact.EmailAddress,'') AS Email
      , Contact.CompanyNameDim.CompanyNameName AS CompanyName
      , '' AS CompanyPhone1
      , '' AS CompanyPhone2
      , '' AS CompanyFax
      , '' AS CompanyEmail
      , '' AS CompanyURL
     -- , REPLACE(Orders.OrderHeaderFact.ZW_Franchise_ID, 'FSI', '') AS WebNo
      , SUBSTRING(REPLACE(Orders.OrderHeaderFact.ZW_Franchise_ID, 'FSI', ''),
                  PATINDEX('%[^0]%',
                           REPLACE(Orders.OrderHeaderFact.ZW_Franchise_ID,
                                   'FSI', '') + '.'),
                  LEN(REPLACE(Orders.OrderHeaderFact.ZW_Franchise_ID, 'FSI',
                              ''))) AS WebNo   /* remove leading zeroes */
      , Contact.ContactFact.CustomerID
      , Contact.IndustryTypeDim.CleanedIndustry AS Industry /* cleaned to 37 per Marketing */
      , Orders.OriginTypeDim.MarketingType AS Source
   --   , KeyStone.Marketing.Category /* ? */ 
   --   , Orders.OrderHeaderFact.PickedUpDate
      , ( YEAR(Orders.OrderHeaderFact.OrderDate) * 10000 ) + ( MONTH(Orders.OrderHeaderFact.OrderDate) * 100 ) + DAY(Orders.OrderHeaderFact.OrderDate) AS LastOrderDate 
   --   , Orders.OrderHeaderFact.OrderDate

FROM    Orders.OrderHeaderFact   WITH ( NOLOCK ) 
        INNER JOIN Contact.CustomerFact   WITH ( NOLOCK ) ON Orders.OrderHeaderFact.CustomerKey = Contact.CustomerFact.CustomerKey
        LEFT JOIN Orders.OriginLink   WITH ( NOLOCK ) ON Contact.CustomerFact.CustomerTypeID = Orders.OriginLink.CustomerTypeID
                                       AND Contact.CustomerFact.ZW_Franchise_ID = Orders.OriginLink.ZW_Franchise_ID
        LEFT JOIN Orders.OriginTypeDim   WITH ( NOLOCK ) ON Orders.OriginLink.OriginTypeKey = Orders.OriginTypeDim.OriginTypeKey
        LEFT JOIN KeyStone.Marketing   WITH ( NOLOCK ) ON Orders.OriginTypeDim.MarketingType = KeyStone.Marketing.subcategory
        INNER JOIN Contact.ContactFact   WITH ( NOLOCK ) ON Contact.CustomerFact.PrimaryContactKey = Contact.ContactFact.ContactKey
		LEFT JOIN Contact.CountryDim   WITH ( NOLOCK ) ON Contact.CustomerFact.CountryKey = Contact.CountryDim.CountryKey
        LEFT JOIN Contact.CountyDim   WITH ( NOLOCK ) ON Contact.CountyDim.CountyKey = Contact.CustomerFact.CountyKey
        INNER JOIN Contact.CompanyNameDim   WITH ( NOLOCK ) ON Contact.CustomerFact.CompanyNameKey = Contact.CompanyNameDim.CompanyNameKey
        INNER JOIN Contact.IndustryDim   WITH ( NOLOCK ) ON Contact.CustomerFact.IndustryTypeID = Contact.IndustryDim.IndustryTypeID
                                          AND Contact.CustomerFact.ZW_Franchise_ID = Contact.IndustryDim.ZW_Franchise_ID
        INNER JOIN Contact.IndustryTypeDim   WITH ( NOLOCK ) ON Contact.IndustryDim.IndustryTypeKey = Contact.IndustryTypeDim.IndustryTypeKey
       INNER JOIN Contact.ZipDim   WITH ( NOLOCK ) ON Contact.CustomerFact.ZipKey = Contact.ZipDim.ZipKey
        JOIN Store.StoreFact   WITH ( NOLOCK ) ON Orders.OrderHeaderFact.CenterKey = Store.StoreFact.CenterKey
        JOIN Store.OperationalDim   WITH ( NOLOCK ) ON Store.StoreFact.OperationalKey = Store.OperationalDim.OperationalKey
WHERE   Store.OperationalDim.OperationalName <> 'Closed'
        AND Orders.OrderHeaderFact.PickedUpDate IS NOT NULL
            --AND Contact.CountryDim.CountryCode IN ( 'US', 'CA', 'GB', 'AU' )
			--AND Orders.OrderHeaderFact.ZW_Franchise_ID = 'FSI1950'

        AND Orders.OrderHeaderFact.OrderDate IN (
        SELECT  MAX(fact.OrderDate)
        FROM    [Orders].[OrderHeaderFact] fact
        WHERE   -- fact.ContactKey = Contact.ContactFact.ContactKey /* efw */
                fact.CustomerKey = Contact.CustomerFact.CustomerKey )
        AND Orders.OrderHeaderFact.OrderDate >= DATEADD(year,-3,GETDATE()) -- '2010-01-01 00:00:00.000'  --'1980-01-01 00:00:00.000' /* 1980 really? */
        AND Orders.OrderHeaderFact.OrderDate < GETDATE()
        AND ( ( LEN(LTRIM(RTRIM(COALESCE(Contact.CustomerFact.BillingAddress1,
                                         '')))) > 1 )
              OR ( LEN(LTRIM(RTRIM(COALESCE(Contact.CustomerFact.BillingAddress2,
                                            '')))) > 1 )
            )
        AND Contact.ContactFact.FirstName NOT IN ( 'A .', '. .', '* *', '- -',
                                                   'cash customer',
                                                   'cash sale', 'cash cash',
                                                   'cash .', 'cash *',
                                                   'dead customer',
                                                   'none none', 'none .' )
        AND Contact.ContactFact.FirstName NOT LIKE '%(none)%'
        AND Contact.ContactFact.FirstName NOT LIKE '%FASTSIGNS%'
        AND Contact.ContactFact.LastName NOT IN ( 'A .', '. .', '* *', '- -',
                                                  'cash customer', 'cash sale',
                                                  'cash cash', 'cash .',
                                                  'cash *', 'dead customer',
                                                  'none none', 'none .' )
        AND Contact.ContactFact.LastName NOT LIKE '%(none)%'
        AND Contact.ContactFact.LastName NOT LIKE '%FASTSIGNS%'
        AND [Contact].[CompanyNameDim].CompanyNameName NOT IN ( 'cash',
                                                              'cash customer',
                                                              'cash sale',
                                                              'cash cash',
                                                              'cash .',
                                                              'cash *',
                                                              'dead customer',
                                                              'none none',
                                                              'none .' )
        AND [Contact].[CompanyNameDim].CompanyNameName NOT LIKE '%(none)%'
        AND [Contact].[CompanyNameDim].CompanyNameName NOT LIKE '%FASTSIGNS%'
        AND Contact.CustomerFact.BillingAddress1 NOT IN ( 'cash',
                                                          'cash customer',
                                                          'cash sale',
                                                          'cash cash',
                                                          'cash .', 'cash *',
                                                          'dead customer',
                                                          'none none',
                                                          'none .' )
        AND Contact.CustomerFact.BillingAddress1 NOT LIKE '%(none)%'
        AND Contact.CustomerFact.BillingAddress1 NOT LIKE '%DO NOT SEND%'
 AND Contact.CustomerFact.BillingAddress1 NOT LIKE '%FASTSIGNS%'
        AND COALESCE(Contact.CustomerFact.BillingAddress2, '') NOT LIKE '%FASTSIGNS%'
        AND COALESCE(Contact.CustomerFact.BillingAddress2, '') NOT LIKE '%DO NOT SEND%'
	

		--AND dbo.IsAllPrintableCharacters(
		--    --    (ISNULL( Contact.CountryDim.CountryCode,'')    /* scrubbed in the ODS */
		--	--	+ ISNULL(Contact.CustomerFact.[State],'') 
		--		+ ISNULL (Contact.CountyDim.CountyName,'')
		--	--	+ ISNULL(Contact.ZipDim.ZipName,'')       /* scrubbed in the ODS */
		--		+ ISNULL(Contact.CustomerFact.City,'') 
		--		+ ISNULL(Contact.CustomerFact.BillingAddress1,'')
		--		+ ISNULL(COALESCE(Contact.CustomerFact.BillingAddress2,''),'')
		--		+ ISNULL(COALESCE(Contact.ContactFact.FirstName,''),'')
		--		+ ISNULL(COALESCE(Contact.ContactFact.LastName,''),'') 
		--	--	+ ISNULL(COALESCE(CO.ContactName,''),'')
		--		+ ISNULL(COALESCE(Contact.ContactFact.EmailAddress,''),'') 
		--		+ ISNULL(Contact.CompanyNameDim.CompanyNameName,'')
		--	--	+ LEFT(ISNULL(Contact.IndustryTypeDim.CleanedIndustry,''),36)   /* scrubbed in the ODS */
		--	--	+ LEFT(ISNULL(Orders.OriginTypeDim.MarketingType,''),36))  /* scrubbed in the ODS */
		--		) = 1


GO
