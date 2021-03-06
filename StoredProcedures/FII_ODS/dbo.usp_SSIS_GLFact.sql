/****** Object:  StoredProcedure [dbo].[usp_SSIS_GLFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_GLFact]
 AS 
-- INSERT [GL].[DescriptionDim] table
INSERT INTO [GL].[DescriptionDim](
  [DescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Description] AS [DescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[GLFact] 
  WHERE [Description] NOT IN ( SELECT [DescriptionName] FROM [GL].[DescriptionDim] WHERE [DescriptionName] IS NOT NULL )

-- INSERT [GL].[ModifiedByComputerDim] table
INSERT INTO [GL].[ModifiedByComputerDim](
  [ModifiedByComputerName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ModifiedByComputer] AS [ModifiedByComputerName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[GLFact] 
  WHERE [ModifiedByComputer] NOT IN ( SELECT [ModifiedByComputerName] FROM [GL].[ModifiedByComputerDim] WHERE [ModifiedByComputerName] IS NOT NULL )


GO
