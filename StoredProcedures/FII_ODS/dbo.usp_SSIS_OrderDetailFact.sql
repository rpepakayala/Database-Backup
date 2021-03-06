/****** Object:  StoredProcedure [dbo].[usp_SSIS_OrderDetailFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_OrderDetailFact]
 AS 
-- INSERT [Orders].[ProductCodeDim] table
INSERT INTO [Orders].[ProductCodeDim](
  [ProductCodeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ProductCode] AS [ProductCodeName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [ProductCode] NOT IN ( SELECT [ProductCodeName] FROM [Orders].[ProductCodeDim] WHERE [ProductCodeName] IS NOT NULL)

-- INSERT [Orders].[ForegroundColorDim] table
INSERT INTO [Orders].[ForegroundColorDim](
  [ForegroundColorName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ForegroundColor] AS [ForegroundColorName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [ForegroundColor] NOT IN ( SELECT [ForegroundColorName] FROM [Orders].[ForegroundColorDim]  WHERE [ForegroundColorName] IS NOT NULL)

-- INSERT [Orders].[BackgroundColorDim] table
INSERT INTO [Orders].[BackgroundColorDim](
  [BackgroundColorName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [BackgroundColor] AS [BackgroundColorName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [BackgroundColor] NOT IN ( SELECT [BackgroundColorName] FROM [Orders].[BackgroundColorDim] WHERE [BackgroundColorName] IS NOT NULL)

-- INSERT [Orders].[FontDim] table
INSERT INTO [Orders].[FontDim](
  [FontName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Font] AS [FontName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [Font] NOT IN ( SELECT [FontName] FROM [Orders].[FontDim]  WHERE [FontName] IS NOT NULL) 

-- INSERT [Orders].[DescriptionDim] table
INSERT INTO [Orders].[DescriptionDim](
  [DescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  SUBSTRING([Description],1,2000) AS [DescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE SUBSTRING([Description],1,2000) NOT IN ( SELECT [DescriptionName] FROM [Orders].[DescriptionDim] WHERE [DescriptionName] IS NOT NULL) 

-- INSERT [Orders].[SignTextDim] table
INSERT INTO [Orders].[SignTextDim](
  [SignTextName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [SignText] AS [SignTextName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [SignText] NOT IN ( SELECT [SignTextName] FROM [Orders].[SignTextDim] WHERE [SignTextName] IS NOT NULL)

-- INSERT [Orders].[AVAdditionalDescriptionDim] table
INSERT INTO [Orders].[AVAdditionalDescriptionDim](
  [AVAdditionalDescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [AVAdditionalDescription] AS [AVAdditionalDescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [AVAdditionalDescription] NOT IN ( SELECT [AVAdditionalDescriptionName] FROM [Orders].[AVAdditionalDescriptionDim]  WHERE [AVAdditionalDescriptionName] IS NOT NULL)

-- INSERT [Orders].[ProductionNotesDim] table
INSERT INTO [Orders].[ProductionNotesDim](
  [ProductionNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ProductionNotes] AS [ProductionNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderDetailFact] 
  WHERE [ProductionNotes] NOT IN ( SELECT [ProductionNotesName] FROM [Orders].[ProductionNotesDim]   WHERE [ProductionNotesName] IS NOT NULL)


GO
