/****** Object:  StoredProcedure [dbo].[DeleteExpiredPersistedStreams]    Script Date: 5/15/2018 12:09:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[DeleteExpiredPersistedStreams]
AS
SET NOCOUNT OFF
SET DEADLOCK_PRIORITY LOW
declare @now as datetime = GETDATE();
delete top (10) p
from [KeystoneReportServerTempDB].dbo.PersistedStream p with(readpast)
where p.RefCount = 0 AND p.ExpirationDate < @now;

GO
