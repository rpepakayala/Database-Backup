/****** Object:  StoredProcedure [dbo].[usp_SSIS_EstimateDetailFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_EstimateDetailFact]
 AS 
-- INSERT [Estimate].[ProductCodeDim] table
INSERT INTO [Estimate].[ProductCodeDim](
  [ProductCodeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ProductCode] AS [ProductCodeName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [ProductCode] NOT IN ( SELECT [ProductCodeName] FROM [Estimate].[ProductCodeDim] )

-- INSERT [Estimate].[ForegroundColorDim] table
INSERT INTO [Estimate].[ForegroundColorDim](
  [ForegroundColorName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ForegroundColor] AS [ForegroundColorName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [ForegroundColor] NOT IN ( SELECT [ForegroundColorName] FROM [Estimate].[ForegroundColorDim] )

-- INSERT [Estimate].[BackgroundColorDim] table
INSERT INTO [Estimate].[BackgroundColorDim](
  [BackgroundColorName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [BackgroundColor] AS [BackgroundColorName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [BackgroundColor] NOT IN ( SELECT [BackgroundColorName] FROM [Estimate].[BackgroundColorDim] )

-- INSERT [Estimate].[FontDim] table
INSERT INTO [Estimate].[FontDim](
  [FontName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Font] AS [FontName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [Font] NOT IN ( SELECT [FontName] FROM [Estimate].[FontDim] )

-- INSERT [Estimate].[DescriptionDim] table
INSERT INTO [Estimate].[DescriptionDim](
  [DescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Description] AS [DescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [Description] NOT IN ( SELECT [DescriptionName] FROM [Estimate].[DescriptionDim] )

-- INSERT [Estimate].[SignTextDim] table
INSERT INTO [Estimate].[SignTextDim](
  [SignTextName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [SignText] AS [SignTextName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [SignText] NOT IN ( SELECT [SignTextName] FROM [Estimate].[SignTextDim] )

-- INSERT [Estimate].[AVAdditionalDescriptionDim] table
INSERT INTO [Estimate].[AVAdditionalDescriptionDim](
  [AVAdditionalDescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [AVAdditionalDescription] AS [AVAdditionalDescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [AVAdditionalDescription] NOT IN ( SELECT [AVAdditionalDescriptionName] FROM [Estimate].[AVAdditionalDescriptionDim] )

-- INSERT [Estimate].[ProductionNotesDim] table
INSERT INTO [Estimate].[ProductionNotesDim](
  [ProductionNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ProductionNotes] AS [ProductionNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateDetailFact] 
  WHERE [ProductionNotes] NOT IN ( SELECT [ProductionNotesName] FROM [Estimate].[ProductionNotesDim] )


GO
