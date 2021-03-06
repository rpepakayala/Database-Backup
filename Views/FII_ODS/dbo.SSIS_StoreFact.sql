/****** Object:  View [dbo].[SSIS_StoreFact]    Script Date: 5/15/2018 12:13:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW 
[dbo].[SSIS_StoreFact]
as
SELECT *
FROM
    Store.StoreFact
WHERE
    StoreFact.ZW_Franchise_ID NOT IN ( SELECT
                                        System.StoreControl.ZW_Franchise_ID
                                       FROM
                                        System.StoreControl
                                       WHERE
                                        DataSource <> 'FSI' AND AsOfDate < GETDATE())

GO
