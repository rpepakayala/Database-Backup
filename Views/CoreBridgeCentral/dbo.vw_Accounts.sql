/****** Object:  View [dbo].[vw_Accounts]    Script Date: 5/15/2018 12:13:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Accounts
AS
    SELECT
        vw_Locations.ZW_Franchise_ID ,
        AccountConsolidated.ID ,
        AccountConsolidated.FranchiseName ,
        AccountConsolidated.AccountId ,
        AccountConsolidated.LocationId ,
        AccountConsolidated.CompanyName ,
        AccountConsolidated.AccountNumber ,
        AccountConsolidated.PrimaryAccountContactId ,
        AccountConsolidated.BillingContactId ,
        AccountConsolidated.PrimaryPhoneNumber ,
        AccountConsolidated.PrimaryPhoneNumberTypeText ,
        AccountConsolidated.SecondaryPhoneNumber ,
        AccountConsolidated.SecondaryPhoneNumberTypeText ,
        AccountConsolidated.TertiaryPhoneNumber ,
        AccountConsolidated.TertiaryPhoneNumberTypeText ,
        AccountConsolidated.IndustryType ,
        AccountConsolidated.FirstOrderDate ,
        AccountConsolidated.LastOrderDate ,
        AccountConsolidated.LastSaleAmount ,
        AccountConsolidated.IsUpdate ,
        AccountConsolidated.OLTP_InsertDate
    FROM
        AccountConsolidated
        INNER JOIN vw_Locations ON vw_Locations.Value = AccountConsolidated.CompanyLocationId
GO
