/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSummaryByHost]    Script Date: 5/15/2018 12:13:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_GetSummaryByHost
@Order int,
@Count int,
@Dir bit
AS
DECLARE @dummyCount int
SET @dummyCount = @Count + 1
SET ROWCOUNT @dummyCount
DECLARE authors_cursor CURSOR SCROLL FOR
SELECT SuccessCount from MSSCrawlHostList with (nolock) where HostName != ''
DECLARE @dummyVar int
OPEN authors_cursor
FETCH RELATIVE @dummyCount FROM authors_cursor into @dummyVar
IF ( @@FETCH_STATUS = 0)
BEGIN
 select @dummyCount
END
ELSE
BEGIN
 select -1
END
CLOSE authors_cursor
DEALLOCATE authors_cursor
SET ROWCOUNT @Count
IF (@Order=0 and @Dir = 0)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by HostName asc
END
ELSE IF (@Order=0 and @Dir =1)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by HostName desc
END
ELSE IF (@Order=1 and @Dir = 0)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by SuccessCount asc
END
ELSE IF (@Order=1 and @Dir =1)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by SuccessCount desc
END
ELSE IF (@Order=2 and @Dir =0)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by WarningCount asc
END
ELSE IF (@Order=2 and @Dir =1)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by WarningCount desc
END
ELSE IF (@Order=3 and @Dir =0)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by ErrorCount asc
END
ELSE IF (@Order=3 and @Dir =1)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by ErrorCount desc
END
ELSE IF (@Order=4 and @Dir =0)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by TotalCount asc
END
ELSE IF (@Order=4 and @Dir =1)
BEGIN
	SELECT HostName, SuccessCount, WarningCount, ErrorCount, SuccessCount + WarningCount + ErrorCount as TotalCount 
 	FROM MSSCrawlHostList with (nolock) where HostName != '' and SuccessCount + WarningCount + ErrorCount > 0 order by TotalCount desc
END
SET ROWCOUNT 0

GO
