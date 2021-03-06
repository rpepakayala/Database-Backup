/****** Object:  View [dbo].[vw_Orders]    Script Date: 5/15/2018 12:13:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Orders
AS
    SELECT
        vw_Locations.ZW_Franchise_ID ,
        OrderConsolidated.ID ,
        OrderConsolidated.FranchiseName ,
        OrderConsolidated.OrderId ,
        OrderConsolidated.LocationId ,
        OrderConsolidated.ProductionFacilityId ,
        OrderConsolidated.AccountId ,
        OrderConsolidated.ShippingContactId ,
        OrderConsolidated.InvoiceContactId ,
        OrderConsolidated.OrderContactId ,
        OrderConsolidated.ShippingAddressId ,
        OrderConsolidated.InvoiceAddressId ,
        OrderConsolidated.IsUpdate ,
        OrderConsolidated.OLTP_InsertDate
    FROM
        OrderConsolidated
        INNER JOIN vw_Locations ON vw_Locations.Value = OrderConsolidated.CompanyLocationId
GO
