/****** Object:  View [dbo].[ExtendedDataSets]    Script Date: 5/15/2018 12:14:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].ExtendedDataSets
AS 
SELECT 
	ID, LinkID, [Name], ItemID
FROM DataSets
UNION ALL
SELECT
	ID, LinkID, [Name], ItemID
FROM [KeystoneReportServerTempDB].dbo.TempDataSets

GO
