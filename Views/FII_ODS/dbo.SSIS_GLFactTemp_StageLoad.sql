/****** Object:  View [dbo].[SSIS_GLFactTemp_StageLoad]    Script Date: 5/15/2018 12:13:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



CREATE VIEW [dbo].[SSIS_GLFactTemp_StageLoad]
AS
    SELECT
        [Staging].[dbo].[GLFact].* ,
        DescriptionDim.DescriptionKey ,
        ModifiedByComputerDim.ModifiedByComputerKey ,
        StoreFact.CenterKey ,
        OrderKey = ISNULL(OrderHeaderFact.OrderHeaderKey, -255) ,
        CustomerKey = ISNULL(CustomerFact.CustomerKey, -255) ,
        [UserKey] = ISNULL(EmployeeFact.EmployeeKey, -255) ,
        [EnteredByKey] = ISNULL(EE2.EmployeeKey, -255)
    FROM
        [Staging].[dbo].[GLFact]
        LEFT JOIN [GL].[DescriptionDim] WITH ( NOLOCK ) ON [GL].[DescriptionDim].[DescriptionName] = [GLFact].[Description]
        LEFT JOIN [GL].[ModifiedByComputerDim] WITH ( NOLOCK ) ON [GL].[ModifiedByComputerDim].[ModifiedByComputerName] = [GLFact].[ModifiedByComputer]
        JOIN Store.StoreFact WITH ( NOLOCK ) ON GLFact.ZW_Franchise_ID = StoreFact.ZW_Franchise_ID
        LEFT JOIN Orders.OrderHeaderFact WITH ( NOLOCK ) ON StoreFact.CenterKey = Orders.OrderHeaderFact.CenterKey
                                                            AND GLFact.OrderID = Orders.OrderHeaderFact.OrderID
        LEFT JOIN Contact.CustomerFact WITH ( NOLOCK ) ON StoreFact.CenterKey = Contact.CustomerFact.CenterKey
                                                          AND Orders.OrderHeaderFact.CustomerID = Contact.CustomerFact.CustomerID
        LEFT JOIN Contact.EmployeeFact WITH ( NOLOCK ) ON StoreFact.CenterKey = Contact.EmployeeFact.CenterKey
                                                          AND Contact.EmployeeFact.EmployeeID = GLFact.UserID
        LEFT JOIN Contact.EmployeeFact EE2 WITH ( NOLOCK ) ON StoreFact.CenterKey = EE2.CenterKey
                                                              AND EE2.EmployeeID = GLFact.EnteredByID



GO
