/****** Object:  StoredProcedure [dbo].[usp_SSIS_EstimateHeaderFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_EstimateHeaderFact]
 AS 
-- INSERT [Estimate].[DescriptionDim] table
INSERT INTO [Estimate].[DescriptionDim](
  [DescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Description] AS [DescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [Description] NOT IN ( SELECT [DescriptionName] FROM [Estimate].[DescriptionDim] )

-- INSERT [Estimate].[OrdererFirstNameDim] table
INSERT INTO [Estimate].[OrdererFirstNameDim](
  [OrdererFirstNameName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [OrdererFirstName] AS [OrdererFirstNameName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [OrdererFirstName] NOT IN ( SELECT [OrdererFirstNameName] FROM [Estimate].[OrdererFirstNameDim] )

-- INSERT [Estimate].[OrdererLastNameDim] table
INSERT INTO [Estimate].[OrdererLastNameDim](
  [OrdererLastNameName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [OrdererLastName] AS [OrdererLastNameName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [OrdererLastName] NOT IN ( SELECT [OrdererLastNameName] FROM [Estimate].[OrdererLastNameDim] )

-- INSERT [Estimate].[OrdererTitleDim] table
INSERT INTO [Estimate].[OrdererTitleDim](
  [OrdererTitleName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [OrdererTitle] AS [OrdererTitleName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [OrdererTitle] NOT IN ( SELECT [OrdererTitleName] FROM [Estimate].[OrdererTitleDim] )

-- INSERT [Estimate].[StatusDim] table
INSERT INTO [Estimate].[StatusDim](
  [StatusName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Status] AS [StatusName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [Status] NOT IN ( SELECT [StatusName] FROM [Estimate].[StatusDim] )

-- INSERT [Estimate].[PurchaseOrderNumberDim] table
INSERT INTO [Estimate].[PurchaseOrderNumberDim](
  [PurchaseOrderNumberName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [PurchaseOrderNumber] AS [PurchaseOrderNumberName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [PurchaseOrderNumber] NOT IN ( SELECT [PurchaseOrderNumberName] FROM [Estimate].[PurchaseOrderNumberDim] )

-- INSERT [Estimate].[ShippingAddressDim] table
INSERT INTO [Estimate].[ShippingAddressDim](
  [ShippingAddressName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ShippingAddress] AS [ShippingAddressName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [ShippingAddress] NOT IN ( SELECT [ShippingAddressName] FROM [Estimate].[ShippingAddressDim] )

-- INSERT [Estimate].[DispositionOnCompletionDim] table
INSERT INTO [Estimate].[DispositionOnCompletionDim](
  [DispositionOnCompletionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [DispositionOnCompletion] AS [DispositionOnCompletionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [DispositionOnCompletion] NOT IN ( SELECT [DispositionOnCompletionName] FROM [Estimate].[DispositionOnCompletionDim] )

-- INSERT [Estimate].[OrderNotesDim] table
INSERT INTO [Estimate].[OrderNotesDim](
  [OrderNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [OrderNotes] AS [OrderNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [OrderNotes] NOT IN ( SELECT [OrderNotesName] FROM [Estimate].[OrderNotesDim] )

-- INSERT [Estimate].[InstallNotesDim] table
INSERT INTO [Estimate].[InstallNotesDim](
  [InstallNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [InstallNotes] AS [InstallNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [InstallNotes] NOT IN ( SELECT [InstallNotesName] FROM [Estimate].[InstallNotesDim] )

-- INSERT [Estimate].[CustomerNameDim] table
INSERT INTO [Estimate].[CustomerNameDim](
  [CustomerNameName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [CustomerName] AS [CustomerNameName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [CustomerName] NOT IN ( SELECT [CustomerNameName] FROM [Estimate].[CustomerNameDim] )

-- INSERT [Estimate].[JobBoxDim] table
INSERT INTO [Estimate].[JobBoxDim](
  [JobBoxName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [JobBox] AS [JobBoxName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[EstimateHeaderFact] 
  WHERE [JobBox] NOT IN ( SELECT [JobBoxName] FROM [Estimate].[JobBoxDim] )


GO
