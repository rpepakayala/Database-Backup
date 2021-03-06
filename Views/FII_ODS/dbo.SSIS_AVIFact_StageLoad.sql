/****** Object:  View [dbo].[SSIS_AVIFact_StageLoad]    Script Date: 5/15/2018 12:13:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[SSIS_AVIFact_StageLoad]
 AS 
SELECT [Staging].[dbo].[AVIFact].* 
   ,AVCodeKey 
   ,PrintAsKey 
   ,DescriptionKey 
   ,QuestionKey 
FROM [Staging].[dbo].[AVIFact] 
LEFT JOIN [Product].[AVCodeDim] WITH (NOLOCK) ON [Product].[AVCodeDim].[AVCodeName]=[AVIFact].[AVCode] 
LEFT JOIN [Product].[PrintAsDim] WITH (NOLOCK) ON [Product].[PrintAsDim].[PrintAsName]=[AVIFact].[PrintAs] 
LEFT JOIN [Product].[DescriptionDim] WITH (NOLOCK) ON [Product].[DescriptionDim].[DescriptionName]=[AVIFact].[Description] 
LEFT JOIN [Product].[QuestionDim] WITH (NOLOCK) ON [Product].[QuestionDim].[QuestionName]=[AVIFact].[Question] 

GO
