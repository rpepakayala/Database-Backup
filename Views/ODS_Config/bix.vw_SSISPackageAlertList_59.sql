/****** Object:  View [bix].[vw_SSISPackageAlertList_59]    Script Date: 5/15/2018 12:14:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [bix].[vw_SSISPackageAlertList_59]
AS
(
    SELECT 
        [AlertID],
        [AlertCode],
        [CompareAction],
        [AlertKeywords],
        [AlertDescription],
        [FilterThisAlert]
    FROM [dbo].[SSISPackageAlertList]
)
GO
