/****** Object:  StoredProcedure [dbo].[SystinoOrders_Enum_ODS]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[SystinoOrders_Enum_ODS]
    @GPickedUpDate2 DATETIME ,
    @LPickedUpDate2 DATETIME
AS

--DECLARE
--    @GPickedUpDate2 DATETIME ,
--    @LPickedUpDate2 DATETIME
--SET @GPickedUpDate2 = GETDATE() - 10
--SET @LPickedUpDate2 = GETDATE() - 3;  

    SELECT TOP 100
        [od].[OrderID] AS OrderID ,
        [sd].[StoreNumber] AS StoreID ,
        [sd].[StoreNumber] AS StoreNumber ,
        [od].[PricingRatio] ,
        Orders.DescriptionDim.[DescriptionName] AS [OrderDescription] ,
        Orders.StatusDim.[StatusName] AS [status] ,
        [od].[NumberItems] ,
        [od].[CustomerID] AS CustomerID ,
        [od].[ContactID] AS ContactID ,
        [od].[OrdererFirstName] ,
        [od].[OrdererLastName] ,
        [od].[OrdererTitle] ,
        [od].[OrdererPareaCode] ,
        [od].[OrdererPhoneNumber] ,
        [od].[OrdererPhoneExtention] ,
        [od].[OrdererFareaCode] ,
        [od].[OrdererFaxNumber] ,
        [od].[OrdererEmailAddress] ,
        [od].[OrderOriginID] ,
        [od].[InterestAmount] ,
        [od].[SalesTotal] ,
        [od].[ZW_Franchise_ID] AS zw_franchise_id ,
        [od].[OrdererEmailAddress] AS OrdererEmailAddress1 ,
        [od].[PickedUpDate] ,
        [cd].[BillingAddress1] ,
        [cd].[BillingAddress2] ,
        [cd].[City] ,
        [cd].[State] ,
        [Contact].[ZipDim].[ZipName] AS [Zip] ,
        od.CustomerName AS [CompanyName] ,
        ccd.CountryName AS Country ,
        [sd].[StoreOpenDate] ,
        sd.Region AS [SalesRegionName] ,
        Store.CountryDim.[CountryCode]
    FROM
        Orders.OrderHeaderFact od WITH ( NOLOCK )
        JOIN Store.StoreFact sd WITH ( NOLOCK ) ON od.CenterKey = sd.CenterKey
        LEFT OUTER JOIN System.SystinoSubmittedOrders sso WITH ( NOLOCK ) ON [od].[OrderID] = [sso].[OrderID]
                                                              AND [od].[ZW_Franchise_ID] = [sso].[FranchiseID]
        LEFT OUTER JOIN Contact.CustomerFact cd WITH ( NOLOCK ) ON cd.CustomerKey = od.CustomerKey
        LEFT JOIN Store.CountryDim WITH ( NOLOCK ) ON sd.CountryKey = Store.CountryDim.CountryKey
        LEFT JOIN Orders.DescriptionDim WITH ( NOLOCK ) ON od.DescriptionKey = Orders.DescriptionDim.DescriptionKey
        LEFT JOIN Orders.StatusDim WITH ( NOLOCK ) ON od.StatusKey = Orders.StatusDim.StatusKey
        LEFT JOIN [Contact].[ZipDim] WITH ( NOLOCK ) ON cd.ZipKey = [Contact].[ZipDim].ZipKey
        LEFT JOIN Contact.CompanyNameDim WITH ( NOLOCK ) ON cd.CompanyNameKey = Contact.CompanyNameDim.CompanyNameKey
        LEFT JOIN Contact.CountryDim ccd WITH ( NOLOCK ) ON cd.CountryKey = ccd.CountryKey
        Left JOIN Contact.IndustryDim ON cd.IndustryTypeID = Contact.IndustryDim.IndustryTypeID
                                          AND cd.ZW_Franchise_ID = Contact.IndustryDim.ZW_Franchise_ID
        Left JOIN Contact.IndustryTypeDim ON Contact.IndustryDim.IndustryTypeKey = Contact.IndustryTypeDim.IndustryTypeKey
                                              AND Contact.IndustryTypeDim.IndustryTypeName <> 'TRTA'

    WHERE
        [od].[PickedUpDate] > @GPickedUpDate2
        AND [od].[PickedUpDate] < @LPickedUpDate2
        AND [sso].[Submitted] IS NULL
        AND [od].[OrdererEmailAddress] IS NOT NULL
		AND ISNULL(Contact.IndustryTypeDim.IndustryTypeName,'') <> 'TRTA'
		--7/18/2016 new business rule, only orders over $150 get a survey
		AND od.SalesTotal > 150
;

--GRANT EXECUTE ON dbo.SystinoOrders_Enum_ODS to [FASTSIGNS\app_systino_prod]
GO
