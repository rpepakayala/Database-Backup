/****** Object:  View [dbo].[SSIS_OrderHeaderFact_StageLoad]    Script Date: 5/15/2018 12:13:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON







CREATE VIEW [dbo].[SSIS_OrderHeaderFact_StageLoad]
 AS 
SELECT OrderHeaderFact.*
   ,DescriptionKey 
   ,StatusKey 
   ,PurchaseOrderNumberKey 
   ,OrderNotesKey 
   ,InstallNotesKey 
   ,Store.CenterKey
   ,ISNULL(SalesPerson.EmployeeKey,-255) AS SalesPersonKey
   ,ISNULL(Customer.CustomerKey,-255) AS CustomerKey
   ,ISNULL(Employee.EmployeeKey,-255) AS EnteredByKey
   ,ISNULL(Contact.ContactKey,-255) AS ContactKey
FROM [Staging].[dbo].[OrderHeaderFact] 
LEFT JOIN [Orders].[DescriptionDim]  ON [Orders].[DescriptionDim].[DescriptionName]=[OrderHeaderFact].[Description] 
LEFT JOIN [Orders].[StatusDim]  ON [Orders].[StatusDim].[StatusName]=[OrderHeaderFact].[Status] 
LEFT JOIN [Orders].[PurchaseOrderNumberDim]  ON [Orders].[PurchaseOrderNumberDim].[PurchaseOrderNumberName]=[OrderHeaderFact].[PurchaseOrderNumber] 
LEFT JOIN [Orders].[OrderNotesDim]  ON [Orders].[OrderNotesDim].[OrderNotesName]=[OrderHeaderFact].[OrderNotes] 
LEFT JOIN [Orders].[InstallNotesDim]  ON [Orders].[InstallNotesDim].[InstallNotesName]=[OrderHeaderFact].[InstallNotes] 
LEFT JOIN Store.StoreFact Store  ON [Staging].[dbo].[OrderHeaderFact].ZW_Franchise_ID = Store.ZW_Franchise_ID
LEFT JOIN Contact.EmployeeFact Employee  ON Store.CenterKey = Employee.CenterKey AND Employee.EmployeeID = EnteredByID
LEFT JOIN Contact.CustomerFact Customer  ON Store.CenterKey = Customer.CenterKey AND [Staging].[dbo].[OrderHeaderFact].CustomerID = Customer.CustomerID
LEFT JOIN Contact.EmployeeFact SalesPerson  ON Store.CenterKey = SalesPerson.CenterKey AND SalesPerson.EmployeeID=[Staging].[dbo].[OrderHeaderFact].SalePersonID
LEFT JOIN Contact.ContactFact Contact  ON Store.CenterKey = Contact.CenterKey AND OrderHeaderFact.ContactID = Contact.ContactID






GO
