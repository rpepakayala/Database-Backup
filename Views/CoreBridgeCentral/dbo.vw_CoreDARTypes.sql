/****** Object:  View [dbo].[vw_CoreDARTypes]    Script Date: 5/15/2018 12:13:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW vw_CoreDARTypes
as
SELECT [ID]
      ,[GroupName]
      ,[SortOrder]
      ,[CountID]
      ,[AmountID]
  FROM [FII_ODS].[Store].[CoreDARTypes]
GO
