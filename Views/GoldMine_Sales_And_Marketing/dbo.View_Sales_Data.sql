/****** Object:  View [dbo].[View_Sales_Data]    Script Date: 5/15/2018 12:13:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE VIEW [dbo].[View_Sales_Data]
AS
SELECT dbo.Sales_Actuals_Goals.STORE, 
    dbo.Sales_Actuals_Goals.MONTH, 
    dbo.Sales_Actuals_Goals.YEAR, 
    dbo.Sales_Actuals_Goals.ACTUAL_SALES, 
    dbo.CONTACT2.USTOREOPD
FROM dbo.Sales_Actuals_Goals INNER JOIN
    dbo.CONTACT1 ON 
    dbo.Sales_Actuals_Goals.STORE = dbo.CONTACT1.KEY1 INNER
     JOIN
    dbo.CONTACT2 ON 
    dbo.CONTACT1.ACCOUNTNO = dbo.CONTACT2.ACCOUNTNO



GO
