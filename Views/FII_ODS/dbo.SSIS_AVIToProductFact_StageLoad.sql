/****** Object:  View [dbo].[SSIS_AVIToProductFact_StageLoad]    Script Date: 5/15/2018 12:13:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[SSIS_AVIToProductFact_StageLoad]
 AS 
SELECT [Staging].[dbo].[AVIToProductFact].* 
FROM [Staging].[dbo].[AVIToProductFact] 

GO
