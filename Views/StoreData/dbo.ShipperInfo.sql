/****** Object:  View [dbo].[ShipperInfo]    Script Date: 5/15/2018 12:14:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW ShipperInfo AS SELECT     OrderNumber, CompanyName, Description, FirstName, LastName, ContactFullName, ContactEmailAddress, PhoneNumber, StreetAddress1, 
                      StreetAddress2, City, State, County, PostalCode, Country, TransactionID, AccountID, SalesPersonName, SalesPersonEmailAddress, 
                      ShipmentandDeliveryConfirmation, 'Invoice #' + CAST(OrderNumber AS Char(10)) AS CustomerReferenceOrderNumber, 
                      'PO #' + CAST(PONumber AS Char(30)) AS CustomerReferencePONumber, StoreName
FROM         (SELECT     TOP (100) PERCENT dbo.TransHeader.OrderNumber, dbo.Account.CompanyName, dbo.TransHeader.Description, 
                                              dbo.AccountContact.FirstName, dbo.AccountContact.LastName, 
                                              dbo.AccountContact.FirstName + ' ' + dbo.AccountContact.LastName AS ContactFullName, 
                                              dbo.AccountContact.EmailAddress AS ContactEmailAddress, dbo.PhoneNumber.FormattedText AS PhoneNumber, 
                                              dbo.Address.StreetAddress1, dbo.Address.StreetAddress2, dbo.Address.City, dbo.Address.State, dbo.Address.County, 
                                              dbo.Address.PostalCode, dbo.Address.Country, dbo.TransHeader.ID AS TransactionID, dbo.TransHeader.AccountID, 
                                              dbo.Store.InvoiceAsOrderNumber AS ShipmentandDeliveryConfirmation, dbo.TransHeader.PONumber, 
                                              dbo.Employee.FirstName + ' ' + dbo.Employee.LastName AS SalesPersonName, 
                                              dbo.Employee.EmailAddress AS SalesPersonEmailAddress, dbo.Store.CompanyName AS StoreName
                       FROM          dbo.Account WITH (NOLOCK) RIGHT OUTER JOIN
                                              dbo.TransHeader WITH (NOLOCK) ON dbo.Account.ID = dbo.TransHeader.ShippingCompanyID LEFT OUTER JOIN
                                              dbo.Employee WITH (NOLOCK) ON dbo.TransHeader.SalesPerson1ID = dbo.Employee.ID LEFT OUTER JOIN
                                              dbo.PhoneNumber WITH (NOLOCK) RIGHT OUTER JOIN
                                              dbo.AccountContact WITH (NOLOCK) ON dbo.PhoneNumber.ID = dbo.AccountContact.MainPhoneNumberID ON 
                                              dbo.TransHeader.ShippingContactID = dbo.AccountContact.ID LEFT OUTER JOIN
                                              dbo.Address WITH (NOLOCK) ON dbo.TransHeader.ShippingAddressID = dbo.Address.ID CROSS JOIN
                                              dbo.Store WITH (NOLOCK)
                       WHERE      (dbo.TransHeader.TransactionType = 1) AND (dbo.Store.ID = 1001)) AS Tempa

GO
