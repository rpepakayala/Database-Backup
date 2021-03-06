/****** Object:  View [dbo].[SSIS_AdjustmentFact_StageLoad]    Script Date: 5/15/2018 12:13:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[SSIS_AdjustmentFact_StageLoad]
 AS 
SELECT [Staging].[dbo].[AdjustmentFact].* 
   ,ReasonKey 
   ,ReasonCodeKey
   ,StoreFact.CenterKey
FROM [Staging].[dbo].[AdjustmentFact] 
LEFT JOIN [Orders].[ReasonDim] WITH (NOLOCK) ON [Orders].[ReasonDim].[ReasonName]=[AdjustmentFact].[Reason] 
LEFT JOIN [Orders].[ReasonCodeDim] WITH (NOLOCK) ON [Orders].[ReasonCodeDim].[ReasonCodeName]=[AdjustmentFact].[ReasonCode] 
JOIN Store.StoreFact WITH (NOLOCK) ON StoreFact.ZW_Franchise_ID = [AdjustmentFact].ZW_Franchise_ID

GO
