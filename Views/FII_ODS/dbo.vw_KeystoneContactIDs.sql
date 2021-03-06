/****** Object:  View [dbo].[vw_KeystoneContactIDs]    Script Date: 5/15/2018 12:13:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE  VIEW [dbo].[vw_KeystoneContactIDs] 
AS
SELECT distinct
  Contact.ContactFact.ZW_Franchise_ID,
  Contact.ContactFact.ContactID,
  Contact.ContactFact.CustomerID,
  ISNULL(Contact.ContactFact.KeystoneContactKey,
  Contact.ContactFact.ZW_Franchise_ID + ':' +
  LTRIM(STR(Contact.ContactFact.ContactID))) AS KeystoneContactKey,
  ISNULL(Contact.ContactFact.KeystoneCustomerKey,
  Contact.ContactFact.ZW_Franchise_ID + ':A' +
  LTRIM(STR(Contact.ContactFact.CustomerID))) AS KeystoneCustomerKey
FROM
  Contact.ContactFact   WITH ( NOLOCK ) 





GO
