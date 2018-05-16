/****** Object:  View [dbo].[SSIS_IndustryDim_StageLoad]    Script Date: 5/15/2018 12:13:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[SSIS_IndustryDim_StageLoad]
 AS 
SELECT [Staging].[dbo].[IndustryDim].* 
   ,IndustryTypeKey 
FROM [Staging].[dbo].[IndustryDim] 
LEFT JOIN [Contact].[IndustryTypeDim] WITH (NOLOCK) ON [Contact].[IndustryTypeDim].[IndustryTypeName]=[IndustryDim].[IndustryType] 

GO
