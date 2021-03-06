/****** Object:  StoredProcedure [dbo].[proc_MSS_ProcessCommitted]    Script Date: 5/15/2018 12:13:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_ProcessCommitted
@FullIncrementalInterval int, @DeleteOnErrorInterval int,
@DocID int,
@StartAddressID int, @ContentSourceID int, @ProjectID int,
@CrawlID int, 
@SourceDocID int, 
@ItemType int, 
@TransactionType int, 
@Scope int, 
@TransactionFlags int, 
@AccessURL nvarchar(2048), @AccessHash int, 
@CompactURL nvarchar(40), @CompactHash int, 
@ParentCompactURL nvarchar(40), @ParentCompactHash int, 
@DisplayURL nvarchar(2048), @DisplayHash int, 
@LastModifiedTime bigint, 
@EndPathFlag int, 
@PropMD5 int, 
@MD5 int, 
@FolderDelCount int, 
@Host nvarchar(300), 
@HostDepth int, 
@EnumerationDepth int, 
@Retry int, 
@IndexType int, 
@SeqID bigint, 
@LCID int,
@UseChangeLog int, 
@ChangeLogBatchID int, 
@ChangeLogCookie nvarchar(200), 
@ErrorDesc nvarchar(1024),
@hrResult int,
@DocPropsMD5 bigint,
@MaxDocId int,
@FolderHighPriority int,
@ItemHighPriority int
AS
    SET NOCOUNT ON  
    DECLARE @ITEMTYPE_INVALIDLINK int SET @ITEMTYPE_INVALIDLINK = 0 DECLARE @ITEMTYPE_STARTADDRESS int SET @ITEMTYPE_STARTADDRESS = 1 DECLARE @ITEMTYPE_LINK int SET @ITEMTYPE_LINK = 2 DECLARE @ITEMTYPE_COMMITTED int SET @ITEMTYPE_COMMITTED = 3 DECLARE @ITEMTYPE_ANCHORNEWLINK int SET @ITEMTYPE_ANCHORNEWLINK = 4 DECLARE @ITEMTYPE_ANCHORCOMMITTED int SET @ITEMTYPE_ANCHORCOMMITTED = 5 DECLARE @ITEMTYPE_ANCHORNOCRAWL int SET @ITEMTYPE_ANCHORNOCRAWL = 6
    DECLARE @ERRORLEVEL_SUCCESS int SET @ERRORLEVEL_SUCCESS = 0 DECLARE @ERRORLEVEL_WARNING int SET @ERRORLEVEL_WARNING = 1 DECLARE @ERRORLEVEL_ERROR int SET @ERRORLEVEL_ERROR = 2
    DECLARE @GTHR_CA_ADD int SET @GTHR_CA_ADD = 0 DECLARE @GTHR_CA_DELETE int SET @GTHR_CA_DELETE = 1 DECLARE @GTHR_CA_MODIFY int SET @GTHR_CA_MODIFY = 2 DECLARE @GTHR_CA_MOVE_RENAME int SET @GTHR_CA_MOVE_RENAME = 3 
    DECLARE @SCOPE_SHALLOW int SET @SCOPE_SHALLOW = 0X0001 DECLARE @SCOPE_DEEP int SET @SCOPE_DEEP = 0X0002
    DECLARE @CRAWLTYPE_FULL int SET @CRAWLTYPE_FULL = 1 DECLARE @CRAWLTYPE_INCREMENTAL int SET @CRAWLTYPE_INCREMENTAL = 2 DECLARE @CRAWLTYPE_DELETE int SET @CRAWLTYPE_DELETE = 6 
    DECLARE @TF_DIRECTORY int SET @TF_DIRECTORY = 0x0004 DECLARE @TF_FOLLOW_DIRECTORIES int SET @TF_FOLLOW_DIRECTORIES = 0x0008 DECLARE @TF_USES_EXTENDED_DIRLINKS int SET @TF_USES_EXTENDED_DIRLINKS = 0x0200 DECLARE @TF_SITE_CONTAINER int SET @TF_SITE_CONTAINER = 0x0000400 DECLARE @TF_RARE_CRAWL int SET @TF_RARE_CRAWL = 0x0000800 DECLARE @TF_USE_LAST_MODIFIED int SET @TF_USE_LAST_MODIFIED = 0x0040 DECLARE @TF_UPDATE_SECURITY_ONLY int SET @TF_UPDATE_SECURITY_ONLY = 0x2000000
    DECLARE @PRTH_S_NOT_MODIFIED int SET @PRTH_S_NOT_MODIFIED = 0x41203 DECLARE @GTHR_E_URL_EXCLUDED int SET @GTHR_E_URL_EXCLUDED = 0x80040d07 DECLARE @GTHR_E_URL_EXCLUDED_DEPTH int SET @GTHR_E_URL_EXCLUDED_DEPTH = 0x80040d08 DECLARE @GTHR_S_NO_INDEX int SET @GTHR_S_NO_INDEX = 0x40D90 DECLARE @WSS_TOKEN_TOO_EARLY int SET @WSS_TOKEN_TOO_EARLY = 0x810200BC 
    DECLARE @DELETE_ERROR int SET @DELETE_ERROR = 1 DECLARE @DELETE_CRAWL int SET @DELETE_CRAWL = 2 DECLARE @DELETE_UNVISITED_FULL int SET @DELETE_UNVISITED_FULL = 3 DECLARE @DELETE_UNVISITED_INC int SET @DELETE_UNVISITED_INC = 4 DECLARE @DELETE_UNVISITED_LOG int SET @DELETE_UNVISITED_LOG = 5 DECLARE @DELETE_RECURSIVE int SET @DELETE_RECURSIVE = 6 DECLARE @DELETE_EXCLUDED int SET @DELETE_EXCLUDED = 7 DECLARE @DELETE_CHANGELOG int SET @DELETE_CHANGELOG = 8 
    DECLARE
    @HisCrawlID int,
    @HisCommitCrawlID int, 
    @HisPropMD5 int,
    @HisErrorID int,
    @HisErrorLevel int,
    @HisUseChangeLog int, 
    @HisParentDocID int,
    @HisLastModifiedTime bigint,
    @HisStartAddressID int,
    @HisLastTouchStart datetime,
    @HisTransactionFlags int,
    @HisAccessURL nvarchar(2048), 
    @HisAccessHash int, 
    @HisFolderDelCount int,
    @HisErrorCount int,
    @HisContentSourceID int,
    @HisSecurityUpdateErrorID int,
    @HostID int,
    @CrawlType int,
    @CreateAddModifyTransaction int,
    @CreateDeleteTransaction int,
    @Excluded int,
    @ErrorID int,
    @ErrorLevel int,
    @MarkDelete bit, 
    @DelErrorLevel int, 
    @TrackIDDel bigint,
    @TrackID bigint,
    @TrackIDLog bigint,
    @DeleteReason int
    SET XACT_ABORT ON
    BEGIN TRANSACTION
    IF @ChangeLogCookie = ''
        SET @ChangeLogCookie = NULL
    SELECT @CrawlType = CrawlType FROM MSSCrawlHistory WHERE CrawlID = @CrawlID
    SELECT @HisCrawlID=CrawlID, @HisCommitCrawlID=CommitCrawlID, @HisUseChangeLog=UseChangeLog,
            @HisPropMD5 = PropMD5, @HisLastModifiedTime = LastModifiedTime, @HisFolderDelCount = FolderDelCount, @HisTransactionFlags = TransactionFlags,
            @HisErrorID=ErrorID, @HisErrorCount=ErrorCount, @HisParentDocID = ParentDocID, @HisContentSourceID = ContentSourceID,
            @HisSecurityUpdateErrorID = SecurityUpdateErrorID
    FROM MSSCrawlURL 
    WHERE MSSCrawlURL.DocID = @DocID
    IF @@ROWCOUNT = 0
    BEGIN
        DELETE FROM MSSCrawlQueue WHERE SeqID = @SeqID
        goto _Done
    END
    EXEC DBO.proc_MSS_GetHostID @host, @HostID OUTPUT
    SET @ErrorLevel = @ERRORLEVEL_SUCCESS
    SET @MarkDelete = 0
    SET @ErrorID = 0
    IF @hrResult != 0
        EXEC dbo.proc_MSS_GetCrawlErrorID @hrResult, @ErrorID OUTPUT, @ErrorLevel OUTPUT, @MarkDelete OUTPUT
    SET @HisErrorLevel = 0
    IF @HisErrorID != 0
        SELECT @HisErrorLevel = ErrorLevel FROM MSSCrawlErrorList WHERE ErrorID = @HisErrorID
    IF @MarkDelete = 0 AND
        @ErrorLevel = @ERRORLEVEL_ERROR  AND
        @HisErrorCount >= @DeleteOnErrorInterval 
            SET @MarkDelete=1
    IF @AccessURL LIKE 'anchorqh:%'
        SET @MarkDelete = 1
    IF @TransactionFlags & @TF_UPDATE_SECURITY_ONLY <> 0
        SET @MarkDelete = 0
    SET @TrackIDDel = NULL
    SET @DelErrorLevel = @ERRORLEVEL_SUCCESS
    SELECT @TrackIDDel = TrackID, @DelErrorLevel = ErrorLevel FROM MSSCrawlDeletedURL
    WHERE AccessHash = @AccessHash AND AccessURL = @AccessURL
    IF @TransactionType = @GTHR_CA_DELETE
    BEGIN
        SELECT @DeleteReason = DeleteReason, @ErrorID = ErrorID
        FROM MSSCrawlQueue
        WHERE DocID = @DocID
        IF @DeleteReason != @DELETE_ERROR
        BEGIN
            SET @ErrorID = 2 
            SET @ErrorLevel = @ERRORLEVEL_WARNING
        END
        ELSE
        BEGIN
            SELECT @ErrorLevel = ErrorLevel
            FROM MSSCrawlErrorList
            WHERE ErrorID = @ErrorID
        END
    END
    DELETE FROM MSSCrawlQueue WHERE SeqID = @SeqID
    IF @ProjectID = 1
    BEGIN 
        EXEC dbo.proc_MSS_UpdateHostStats @HostID, @TransactionType, @MarkDelete, @ErrorID, @ErrorLevel, @HisCommitCrawlID, @HisErrorLevel, @TrackIDDel, @DelErrorLevel
    END
    IF @TrackIDDel IS NOT NULL
    BEGIN
        DELETE FROM MSSCrawlDeletedURL WHERE TrackID = @TrackIDDel
    END 
    IF @CrawlType = @CRAWLTYPE_INCREMENTAL AND 
        (@hrResult = 0 OR @hrResult = @GTHR_S_NO_INDEX) AND 
        @TransactionType = @GTHR_CA_MODIFY AND
        @UseChangeLog = 0 AND
        @ChangeLogCookie IS NULL AND
        @TransactionFlags & @TF_DIRECTORY <> 0 AND
        (@FolderDelCount = 0 OR @FolderDelCount <> @HisFolderDelCount) AND
        @TransactionFlags & @TF_UPDATE_SECURITY_ONLY = 0
    BEGIN
        UPDATE MSSCrawlURL SET ParentUpdateCrawlID = @CrawlID
        WHERE ParentDocID = @DocID AND
            TransactionFlags & @TF_USES_EXTENDED_DIRLINKS <> 0 AND
            TransactionFlags & @TF_DIRECTORY = 0 AND
            UseChangeLog = 0
    END
    IF @CrawlType = @CRAWLTYPE_INCREMENTAL AND 
        (@hrResult = 0 OR @hrResult = @GTHR_S_NO_INDEX) AND 
        @Scope = @SCOPE_DEEP AND
        @TransactionType = @GTHR_CA_MODIFY AND
        @UseChangeLog = 1 AND 
        @ChangeLogCookie IS NULL AND 
        @TransactionFlags & @TF_DIRECTORY <> 0 AND
        @TransactionFlags & @TF_UPDATE_SECURITY_ONLY = 0
    BEGIN
        UPDATE MSSCrawlURL SET ParentUpdateCrawlID = @CrawlID
        WHERE ParentDocID = @DocID AND
            TransactionFlags & @TF_FOLLOW_DIRECTORIES <> 0 AND
            UseChangeLog = 1
    END
    IF @CrawlType = @CRAWLTYPE_INCREMENTAL AND 
        @hrResult = 0 AND 
        @TransactionType = @GTHR_CA_MODIFY AND
        @UseChangeLog = 1 AND 
        @ChangeLogCookie IS NULL AND 
        @TransactionFlags & @TF_DIRECTORY <> 0 AND
        @TransactionFlags & @TF_UPDATE_SECURITY_ONLY <> 0
    BEGIN
        INSERT INTO MSSCrawlQueue (
            CrawlID,
            StartAddressID, 
            DocID,                  
            TransactionType,
            Scope, 
            TransactionFlags,
            HostDepth,
            EnumerationDepth,
            SourceDocID,
            ChangeLogBatchID, 
            ItemType,
            FolderHighPriority,
            ItemHighPriority,
            ProjectID)
        SELECT
           @CrawlID,
           @StartAddressID,
           DocID,
           @GTHR_CA_MODIFY,
           @SCOPE_DEEP,   
           TransactionFlags | @TF_UPDATE_SECURITY_ONLY, 
               HostDepth,
           EnumerationDepth,
           ParentDocID,
           @ChangeLogBatchID,
           @ITEMTYPE_LINK,
           0, 
           ItemHighPriority, 
           @ProjectID
        FROM MSSCrawlURL 
        WHERE ParentDocID = @DocID AND 
            ((TransactionFlags & @TF_USES_EXTENDED_DIRLINKS <> 0 AND TransactionFlags & @TF_DIRECTORY = 0) AND UseChangeLog = 1) AND
            CommitCrawlId <> @CrawlId
    END
    IF @MarkDelete = 1
    BEGIN
        INSERT INTO MSSCrawlQueue (
            CrawlID,
            StartAddressID, 
            DocID,                  
            TransactionType,
            Scope, 
            TransactionFlags,
            HostDepth,
            EnumerationDepth,
            SourceDocID,
            ChangeLogBatchID, 
            ItemType,
            FolderHighPriority,
            ItemHighPriority,
            ProjectID,
            DeleteReason,
            ErrorID)
        VALUES(
            @CrawlID,
            @StartAddressID,
            @DocID,
            @GTHR_CA_DELETE,
            @SCOPE_DEEP,   
            @TransactionFlags, 
            0, 
            0, 
            0, 
            @ChangeLogBatchID,
            @ItemType,
            0, 
            0, 
            @ProjectID,
            @DELETE_ERROR,
            @ErrorID)
    END
    IF  @GTHR_CA_DELETE = @TransactionType
    BEGIN
        EXEC dbo.proc_MSS_ProcessDelete
            @ProjectID,
            @HisContentSourceID,
            @StartAddressID,
            @DocID,
            @CrawlID,
            @HisCrawlID,
            @HisCommitCrawlID,
            @Scope,
            @HisTransactionFlags,
            @UseChangeLog, 
            @ChangeLogCookie,
            @ChangeLogBatchID,
            @DeleteReason,
            @TransactionType, 
            @HostDepth, 
            @EnumerationDepth, 
            @HisParentDocID, 
            @EndPathFlag,
            @HostID,
            @LCID,
            @ErrorID,
            @ErrorLevel,
            @AccessURL, 
            @AccessHash, 
            @CompactURL, 
            @CompactHash,
            @DisplayURL, 
            @DisplayHash,
            @MaxDocId
    END         
    ELSE 
    BEGIN
        IF 0 = @MarkDelete AND @TransactionFlags & @TF_UPDATE_SECURITY_ONLY = 0
        BEGIN
            DECLARE @ErrorCount int
            IF @ErrorLevel = @ERRORLEVEL_ERROR
                SET @ErrorCount = @HisErrorCount + 1
            ELSE
                SET @ErrorCount = 0
            DECLARE @ParentDocID int
            SET @ParentDocID = @SourceDocID
            IF @UseChangeLog = 1 AND @HisParentDocID IS NOT NULL
                SET @ParentDocId = @HisParentDocID
            IF @ChangeLogCookie IS NOT NULL
            BEGIN
                INSERT INTO MSSChangeLogCookies
                SELECT ChangeLogCookie, @ChangeLogCookie, @CrawlID, @DocID, GetDate()
                FROM MSSCrawlURL
                WHERE DocID = @DocID
            END
            UPDATE MSSCrawlURL SET  
                StartAddressID = @StartAddressID,
                ContentSourceID = @ContentSourceID,
                ProjectID = @ProjectID,
                CrawlID = @CrawlID,
                CommitCrawlID = @CrawlID,                       
                AccessURL = @AccessURL,
                AccessHash = @AccessHash,
                CompactURL = @CompactURL,
                CompactHash = @CompactHash,
                DisplayURL = @DisplayURL,
                DisplayHash = @DisplayHash,
                TransactionFlags = @TransactionFlags,
                HostDepth = @HostDepth,
                EnumerationDepth = @EnumerationDepth,
                ParentDocID = @ParentDocID,
                UseChangeLog = @UseChangeLog,
                ChangeLogCookie = @ChangeLogCookie,
                IndexType = @IndexType,
                MD5 = @MD5,
                PropMD5 = @PropMD5,
                Retry = 0,
                LastModifiedTime = @LastModifiedTime,
                FolderDelCount = @FolderDelCount,
                LCID = @LCID,
                EndPathFlag = @EndPathFlag,
                HostID = @HostID,
                ErrorID = @ErrorID,
                ErrorLevel = @ErrorLevel,
                LastTouchStart = GetDate(),
                ErrorCount = @ErrorCount,
                ErrorDesc = @ErrorDesc,
                DocPropsMD5 = @DocPropsMD5,
                CrawlScope = CASE WHEN @ErrorLevel <> @ERRORLEVEL_ERROR THEN 0 ELSE @Scope END,
                FolderHighPriority = @FolderHighPriority,
                ItemHighPriority = @ItemHighPriority,
                SecurityUpdateErrorID = 0
            WHERE   DocID = @DocID
        END
        ELSE
        IF 0 = @MarkDelete AND @TransactionFlags & @TF_UPDATE_SECURITY_ONLY <> 0
            AND (@ErrorLevel = @ERRORLEVEL_ERROR OR @HisSecurityUpdateErrorID <> 0)
        BEGIN
            UPDATE MSSCrawlURL SET SecurityUpdateErrorID = CASE WHEN @ErrorLevel = @ERRORLEVEL_ERROR THEN @ErrorID ELSE 0 END 
                WHERE DocID = @DocID
        END
    END
    IF @TransactionType = @GTHR_CA_MODIFY AND
        @hrResult = @WSS_TOKEN_TOO_EARLY
    BEGIN
        UPDATE MSSCrawlURL 
        SET ChangeLogCookie = NULL
        WHERE DocID = @DocID
        INSERT INTO MSSCrawlQueue (
            CrawlID,
            StartAddressID, 
            DocID,                  
            TransactionType,
            Scope, 
            TransactionFlags,
            HostDepth,
            EnumerationDepth,
            SourceDocID,
            ChangeLogBatchID, 
            ItemType,
            FolderHighPriority,
            ItemHighPriority,
            ProjectID,
            DeleteReason,
            ErrorID)
        VALUES(
            @CrawlID,
            @StartAddressID,
            @DocID,
            @GTHR_CA_MODIFY,
            @SCOPE_DEEP,   
            @TransactionFlags, 
            @HostDepth,
            @EnumerationDepth,
            @HisParentDocID, 
            @ChangeLogBatchID,
            @ItemType,
            0, 
            0, 
            @ProjectID,
            0, --@DELETE_ERROR,
            0 --@ErrorID
        )
    END
    IF @ErrorLevel != @ERRORLEVEL_SUCCESS
    BEGIN
        INSERT INTO MSSCrawlURLLog (
                StartAddressID,
                DocID,
                CrawlID,
                AccessURL,
                AccessHash,
                CompactURL,
                CompactHash,
                DisplayURL,
                DisplayHash,
                TransactionType,
                Scope,
                TransactionFlags,                
                HostDepth,
                EnumerationDepth,            
                ParentDocID,
                UseChangeLog,
                ChangeLogCookie,
                EndPathFlag,
                HostID,
                LCID,
                LastTouchStart,
                ErrorID,
                ErrorDesc)
        VALUES(
                @StartAddressID,
                @DocID,
                @CrawlID,
                @AccessURL,
                @AccessHash,
                @CompactURL,
                @CompactHash,
                @DisplayURL,
                @DisplayHash,
                @TransactionType,
                @Scope,
                @TransactionFlags,
                @HostDepth,
                @EnumerationDepth,
                @SourceDocID,
                @UseChangeLog,
                @ChangeLogCookie,
                @EndPathFlag,
                @HostID,
                @LCID,
                GetDate(),
                @ErrorID,
                @ErrorDesc)
    END
    _Done:
    COMMIT TRANSACTION
    RETURN 1

GO
