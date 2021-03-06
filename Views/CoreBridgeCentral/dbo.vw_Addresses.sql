/****** Object:  View [dbo].[vw_Addresses]    Script Date: 5/15/2018 12:13:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Addresses
AS
    SELECT
        vw_Locations.ZW_Franchise_ID ,
        AddressConsolidated.ID ,
        AddressConsolidated.FranchiseName ,
        AddressConsolidated.AddressId ,
        AddressConsolidated.Address1 ,
        AddressConsolidated.Address2 ,
        AddressConsolidated.Address3 ,
        AddressConsolidated.City ,
        AddressConsolidated.State ,
        AddressConsolidated.County ,
        AddressConsolidated.PostalCode ,
        AddressConsolidated.Country ,
        AddressConsolidated.PostalCodeExtended ,
        AddressConsolidated.IsUpdate ,
        AddressConsolidated.OLTP_InsertDate ,
        AddressConsolidated.OLTP_UpdateDate ,
        AddressConsolidated.UpdateCheckSum
    FROM
        AddressConsolidated
        INNER JOIN vw_Locations ON SUBSTRING(vw_Locations.Value, 1, 4)
                                   + '0000' = AddressConsolidated.CompanyLocationId
GO
