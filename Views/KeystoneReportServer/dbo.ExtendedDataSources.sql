/****** Object:  View [dbo].[ExtendedDataSources]    Script Date: 5/15/2018 12:14:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].ExtendedDataSources
AS 
SELECT 
	DSID, ItemID, SubscriptionID, Name, Extension, Link, 
	CredentialRetrieval, Prompt, ConnectionString, 
	OriginalConnectionString, OriginalConnectStringExpressionBased, 
	UserName, Password, Flags, Version
FROM DataSource
UNION ALL
SELECT
	DSID, ItemID, NULL as [SubscriptionID], Name, Extension, Link, 
	CredentialRetrieval, Prompt, ConnectionString, 
	OriginalConnectionString, OriginalConnectStringExpressionBased, 
	UserName, Password, Flags, Version
FROM [KeystoneReportServerTempDB].dbo.TempDataSources

GO
