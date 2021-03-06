/****** Object:  View [dbo].[vw_ODS_Core_Contacts]    Script Date: 5/15/2018 12:13:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE VIEW [dbo].[vw_ODS_Core_Contacts]
AS
    SELECT
        FastsignsCorebridgeMappings.ZW_Franchise_ID ,
        FastsignsCorebridgeMappings.FastsignsID ,
        FastsignsCorebridgeMappings.CorbridgeID ,
        FII_ODS.Contact.ContactFact.ContactKey ,
        FII_ODS.Contact.ContactFact.FirstName AS ODS_FirstName ,
        FII_ODS.Contact.ContactFact.LastName AS ODS_Lastname ,
        ContactConsolidated.FirstName AS Core_FirstName ,
        ContactConsolidated.LastName AS Core_LastName ,
        ContactConsolidated.EmailAddress ,
        ContactConsolidated.PrimaryPhoneNumber ,
        AccountConsolidated.CompanyName ,
        AccountConsolidated.AccountId AS Core_Account ,
        FII_ODS.Contact.ContactFact.CustomerKey
    FROM
        FastsignsCorebridgeMappings
         JOIN vw_Locations ON FastsignsCorebridgeMappings.ZW_Franchise_ID = vw_Locations.ZW_Franchise_ID
         JOIN ContactConsolidated ON ContactConsolidated.CompanyLocationId = vw_Locations.Value
                                          AND FastsignsCorebridgeMappings.CorbridgeID = ContactConsolidated.ContactId
        Left JOIN FII_ODS.Contact.ContactFact ON FastsignsCorebridgeMappings.ZW_Franchise_ID = FII_ODS.Contact.ContactFact.ZW_Franchise_ID
                                                  AND FastsignsCorebridgeMappings.FastsignsID = FII_ODS.Contact.ContactFact.ContactID
                                                  AND FastsignsCorebridgeMappings.ID_Type = 2
        Left JOIN AccountConsolidated ON ContactConsolidated.AccountId = AccountConsolidated.AccountId
                                          AND ContactConsolidated.CompanyLocationId = AccountConsolidated.CompanyLocationId



GO
