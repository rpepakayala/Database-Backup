/****** Object:  StoredProcedure [dbo].[usp_SSIS_OrderHeaderFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_OrderHeaderFact]
 AS 
-- INSERT [Orders].[DescriptionDim] table
RAISERROR('[Orders].[DescriptionDim]', 0, 1) WITH NOWAIT
INSERT INTO [Orders].[DescriptionDim](
  [DescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Description] AS [DescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderHeaderFact] WITH (NOLOCK)
  WHERE [Description] NOT IN ( SELECT [DescriptionName] FROM [Orders].[DescriptionDim] WHERE [DescriptionName] IS NOT NULL )

-- INSERT [Orders].[StatusDim] table
RAISERROR('[Orders].[StatusDim]', 0, 1) WITH NOWAIT
INSERT INTO [Orders].[StatusDim](
  [StatusName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Status] AS [StatusName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderHeaderFact] WITH (NOLOCK)
  WHERE [Status] NOT IN ( SELECT [StatusName] FROM [Orders].[StatusDim] WHERE [StatusName] IS NOT NULL)

-- INSERT [Orders].[PurchaseOrderNumberDim] table
RAISERROR('[Orders].[PurchaseOrderNumberDim]', 0, 1) WITH NOWAIT
INSERT INTO [Orders].[PurchaseOrderNumberDim](
  [PurchaseOrderNumberName] ,
  [IsValid] ) 
 SELECT DISTINCT
  [PurchaseOrderNumber] AS [PurchaseOrderNumberName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderHeaderFact] WITH (NOLOCK)
  WHERE [PurchaseOrderNumber] NOT IN ( SELECT [PurchaseOrderNumberName] FROM [Orders].[PurchaseOrderNumberDim] WHERE [PurchaseOrderNumberName] IS NOT NULL )

-- INSERT [Orders].[OrderNotesDim] table
RAISERROR('[Orders].[OrderNotesDim]', 0, 1) WITH NOWAIT
INSERT INTO [Orders].[OrderNotesDim](
  [OrderNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [OrderNotes] AS [OrderNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderHeaderFact] WITH (NOLOCK)
  WHERE [OrderNotes] NOT IN ( SELECT [OrderNotesName] FROM [Orders].[OrderNotesDim] WHERE [OrderNotesName] IS NOT NULL  )

-- INSERT [Orders].[InstallNotesDim] table
RAISERROR('[Orders].[InstallNotesDim]', 0, 1) WITH NOWAIT
INSERT INTO [Orders].[InstallNotesDim](
  [InstallNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [InstallNotes] AS [InstallNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[OrderHeaderFact]  WITH (NOLOCK)
  WHERE [InstallNotes] NOT IN ( SELECT [InstallNotesName] FROM [Orders].[InstallNotesDim] WHERE [InstallNotesName] IS NOT NULL )


GO
