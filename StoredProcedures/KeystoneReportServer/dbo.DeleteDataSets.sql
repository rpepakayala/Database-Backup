/****** Object:  StoredProcedure [dbo].[DeleteDataSets]    Script Date: 5/15/2018 12:09:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[DeleteDataSets]
@ItemID [uniqueidentifier]
AS
DELETE
FROM [DataSets]
WHERE [ItemID] = @ItemID
DELETE
FROM [KeystoneReportServerTempDB].dbo.TempDataSets
WHERE [ItemID] = @ItemID

GO
