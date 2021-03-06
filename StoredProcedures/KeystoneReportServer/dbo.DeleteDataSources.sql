/****** Object:  StoredProcedure [dbo].[DeleteDataSources]    Script Date: 5/15/2018 12:09:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[DeleteDataSources]
@ItemID [uniqueidentifier]
AS

DELETE
FROM [DataSource]
WHERE [ItemID] = @ItemID or [SubscriptionID] = @ItemID 
DELETE
FROM [KeystoneReportServerTempDB].dbo.TempDataSources
WHERE [ItemID] = @ItemID

GO
