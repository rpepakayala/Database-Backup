/****** Object:  StoredProcedure [dbo].[usp_SSIS_AdjustmentFact]    Script Date: 5/15/2018 12:09:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_AdjustmentFact]
 AS 
-- INSERT [Orders].[ReasonDim] table
INSERT INTO [Orders].[ReasonDim](
  [ReasonName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Reason] AS [ReasonName] ,
  1 as IsValid 
FROM [Staging].[dbo].[AdjustmentFact] WITH (NOLOCK) 
  WHERE [Reason] NOT IN ( SELECT [ReasonName] FROM [Orders].[ReasonDim] WHERE  [ReasonName] IS NOT NULL  )

-- INSERT [Orders].[ReasonCodeDim] table
INSERT INTO [Orders].[ReasonCodeDim](
  [ReasonCodeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ReasonCode] AS [ReasonCodeName] ,
  1 as IsValid 
FROM [Staging].[dbo].[AdjustmentFact] WITH (NOLOCK) 
  WHERE [ReasonCode] NOT IN ( SELECT [ReasonCodeName] FROM [Orders].[ReasonCodeDim] WHERE  [ReasonCodeName] IS NOT NULL  )


GO
