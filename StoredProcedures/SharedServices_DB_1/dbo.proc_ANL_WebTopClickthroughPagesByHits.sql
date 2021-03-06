/****** Object:  StoredProcedure [dbo].[proc_ANL_WebTopClickthroughPagesByHits]    Script Date: 5/15/2018 12:11:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE PROCEDURE dbo.proc_ANL_WebTopClickthroughPagesByHits
 @webGuid uniqueidentifier
AS

BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @locked INT
EXEC @locked = proc_ANL_LockMasterTablesForRead
IF @locked = -1
BEGIN 
 ROLLBACK TRANSACTION
 RETURN 0
END

SELECT TOP 5 TargetFullUrl, SUM(ClickthroughCount) AS Clickthroughs
FROM ANLPageClickthroughsByDay WITH (NOLOCK)
WHERE ReferrerWebGuid = @webGuid
GROUP BY TargetFullUrl
ORDER BY Clickthroughs DESC

ROLLBACK TRANSACTION
RETURN 1


GO
