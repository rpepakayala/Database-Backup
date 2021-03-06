/****** Object:  View [dbo].[vw_rpt_FranchiseID_CustomerID_FirstOderDate]    Script Date: 5/15/2018 12:13:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[vw_rpt_FranchiseID_CustomerID_FirstOderDate]
AS
--For New Customer Counts by Month and SalesPerson Report
--Selects the Fisrtorder for a customer    
    SELECT
        ZW_Franchise_ID ,
        CustomerID ,
        MIN(OrderDate) AS MinDate
    FROM
        Orders.OrderHeaderFact   WITH ( NOLOCK ) 
    GROUP BY
        ZW_Franchise_ID ,
        CustomerID

GO
