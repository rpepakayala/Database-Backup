/****** Object:  StoredProcedure [dbo].[proc_MSS_UpdateHostStats]    Script Date: 5/15/2018 12:11:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_UpdateHostStats
@HostID int,
@TransactionType int,
@MarkDelete bit,
@ErrorID int,
@ErrorLevel int,
@HisCommitCrawlID int,
@HisErrorLevel int,
@DelTrackID bigint,
@DelErrorLevel int
AS

    DECLARE @ERRORLEVEL_SUCCESS int SET @ERRORLEVEL_SUCCESS = 0 DECLARE @ERRORLEVEL_WARNING int SET @ERRORLEVEL_WARNING = 1 DECLARE @ERRORLEVEL_ERROR int SET @ERRORLEVEL_ERROR = 2
    DECLARE @GTHR_CA_ADD int SET @GTHR_CA_ADD = 0 DECLARE @GTHR_CA_DELETE int SET @GTHR_CA_DELETE = 1 DECLARE @GTHR_CA_MODIFY int SET @GTHR_CA_MODIFY = 2 DECLARE @GTHR_CA_MOVE_RENAME int SET @GTHR_CA_MOVE_RENAME = 3 

    DECLARE
    @SuccessCount int,
    @WarningCount int,
    @ErrorCount int

    SET @SuccessCount = 0
    SET @WarningCount = 0
    SET @ErrorCount = 0

    IF @HisCommitCrawlID != 0
    BEGIN
        IF @HisErrorLevel = @ERRORLEVEL_SUCCESS SET @SuccessCount = @SuccessCount - 1
        IF @HisErrorLevel = @ERRORLEVEL_WARNING SET @WarningCount = @WarningCount - 1
        IF @HisErrorLevel = @ERRORLEVEL_ERROR SET @ErrorCount = @ErrorCount - 1
    END

    IF @DelTrackID IS NOT NULL
    BEGIN

        IF @DelErrorLevel = @ERRORLEVEL_WARNING SET @WarningCount = @WarningCount - 1
        IF @DelErrorLevel = @ERRORLEVEL_ERROR SET @ErrorCount = @ErrorCount - 1
    END

    IF @ErrorLevel = @ERRORLEVEL_SUCCESS SET @SuccessCount = @SuccessCount + 1
    IF @ErrorLevel = @ERRORLEVEL_WARNING SET @WarningCount = @WarningCount + 1
    IF @ErrorLevel = @ERRORLEVEL_ERROR SET @ErrorCount = @ErrorCount + 1

    UPDATE MSSCrawlHostList SET 
        SuccessCount = CASE WHEN SuccessCount + @SuccessCount > 0 THEN SuccessCount + @SuccessCount ELSE 0 END,
        ErrorCount = CASE WHEN ErrorCount + @ErrorCount > 0 THEN ErrorCount + @ErrorCount ELSE 0 END,
        WarningCount = CASE WHEN WarningCount + @WarningCount > 0 THEN WarningCount + @WarningCount ELSE 0 END
    WHERE HostID = @HostID


GO
