/****** Object:  StoredProcedure [dbo].[usp_SSIS_PaymentFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_PaymentFact]
 AS 
-- INSERT [Orders].[PaymentMethodDim] table
INSERT INTO [Orders].[PaymentMethodDim](
  [PaymentMethodName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [PaymentMethod] AS [PaymentMethodName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[PaymentFact] 
  WHERE [PaymentMethod] NOT IN ( SELECT [PaymentMethodName] FROM [Orders].[PaymentMethodDim] )

-- INSERT [Orders].[TrackingNumberDim] table
INSERT INTO [Orders].[TrackingNumberDim](
  [TrackingNumberName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [TrackingNumber] AS [TrackingNumberName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[PaymentFact] 
  WHERE [TrackingNumber] NOT IN ( SELECT [TrackingNumberName] FROM [Orders].[TrackingNumberDim] )

-- INSERT [Orders].[ReasonDim] table
INSERT INTO [Orders].[ReasonDim](
  [ReasonName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Reason] AS [ReasonName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[PaymentFact] 
  WHERE [Reason] NOT IN ( SELECT [ReasonName] FROM [Orders].[ReasonDim] )

-- INSERT [Orders].[TakenForCustomerInfoDim] table
INSERT INTO [Orders].[TakenForCustomerInfoDim](
  [TakenForCustomerInfoName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [TakenForCustomerInfo] AS [TakenForCustomerInfoName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[PaymentFact] 
  WHERE [TakenForCustomerInfo] NOT IN ( SELECT [TakenForCustomerInfoName] FROM [Orders].[TakenForCustomerInfoDim] )


GO
