/****** Object:  StoredProcedure [dbo].[proc_OrphanRecurringEventExceptions]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_OrphanRecurringEventExceptions
(
    @SiteID             uniqueidentifier,
    @ListID             uniqueidentifier,
    @WebID              uniqueidentifier,
    @UID                uniqueidentifier,
    @ServerTemplate     int,
    @SeriesItemID       int,
    @UserID             int,
    @RecurrenceColName  nvarchar(64),
    @RecurrenceRowOrd int = 0,
    @EventTypeColName   nvarchar(64),
    @EventTypeRowOrd int = 0,
    @RecDataColName     nvarchar(64),
    @RecDataRowOrd int = 0,
    @UIDColName         nvarchar(64),
    @UIDRowOrd int = 0
)
AS
    SET NOCOUNT ON
    DECLARE @CleanupStr nvarchar(2000)
    SET @CleanupStr = N'';
    IF @RecurrenceColName IS NOT NULL AND
        @EventTypeColName  IS NOT NULL AND
        @RecDataColName    IS NOT NULL AND
        @UIDColName        IS NOT NULL
    BEGIN
        SET @CleanupStr = @EventTypeColName +  N' = 0,'
            + @RecurrenceColName + N' = NULL,'
            + @UIDColName +        N' = NULL,'
            + @RecDataColName +    N' = NULL'
    END
    IF (DATALENGTH(@CleanupStr) != 0)
    BEGIN
        BEGIN TRAN
        DECLARE @ExecStr nvarchar(3000)
        DECLARE @ParamStr nvarchar(3000)
        DECLARE @DTM datetime
        SELECT @DTM = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        DECLARE @Orphans_cursor CURSOR
        DECLARE @InstanceID int
        CREATE TABLE #OrphanRecurringEventExceptions (tp_ID int)
        SELECT @ExecStr = N'
         INSERT INTO #OrphanRecurringEventExceptions
                 SELECT UserData.tp_ID 
                 FROM UserData
                 WHERE
                       tp_ListID = @ListID AND '+
                       @UIDColName + N' IS NOT NULL AND '+
                       @UIDColName  + N' = @UID AND tp_ID != @SeriesItemID'
          SELECT @ParamStr = N' @ListID uniqueidentifier, @UID uniqueidentifier, @SeriesItemID int'
          IF @UIDRowOrd <> 0
              BEGIN
                SELECT @ExecStr = @ExecStr + N'
                    AND tp_RowOrdinal = @UIDRowOrd'
                SELECT @ParamStr = @ParamStr+ N', @UIDRowOrd int'
               EXEC sp_executesql @ExecStr, @ParamStr,
                      @ListID, @UID, @SeriesItemID, @UIDRowOrd
              END
          ELSE
              BEGIN
               EXEC sp_executesql @ExecStr, @ParamStr,
                      @ListID, @UID, @SeriesItemID
              END        
          SELECT @ExecStr = N'
              UPDATE
                  DBO.UserData
              SET
                  tp_Version = tp_Version + 1,
                  tp_Modified = @DTM '
                  + @CleanupStr + N'
              WHERE
                  tp_ListID = @ListID AND '+
                  @UIDColName + N' IS NOT NULL AND '+
                  @UIDColName  + N' = @UID AND tp_ID != @SeriesItemID'
           SELECT @ParamStr =N'@ListID uniqueidentifier,@UID uniqueidentifier, @DTM datetime, @SeriesItemID int'
          IF @UIDRowOrd <> 0
              BEGIN
                SELECT @ExecStr = @ExecStr + N'
                    AND tp_RowOrdinal = @UIDRowOrd'
                SELECT @ParamStr = @ParamStr+ N', @UIDRowOrd int'
               EXEC sp_executesql @ExecStr, @ParamStr,
                   @ListID,@UIDColName, @UID, @DTM, @SeriesItemID, @UIDRowOrd
              END
          ELSE
              BEGIN
               EXEC sp_executesql @ExecStr, @ParamStr,
                  @ListID,@UIDColName, @UID, @DTM, @SeriesItemID
              END        
        SET @Orphans_cursor = CURSOR
              LOCAL
              FAST_FORWARD
        FOR 
          SELECT tp_ID
          FROM #OrphanRecurringEventExceptions
        OPEN @Orphans_cursor
        FETCH NEXT FROM @Orphans_cursor
          INTO @InstanceID
          WHILE @@FETCH_STATUS = 0
          BEGIN
              EXEC proc_DropListRecord
                  @SiteID,
                  @WebID, 
                  @ListID, 
                  @ServerTemplate,
                  @InstanceID, 
                  1, 
                  0, 
                  NULL,
                  NULL,
                  @UserID, 
                  0, 
                  NULL, 
                  4 
           FETCH NEXT FROM  @Orphans_cursor
           INTO @InstanceID
        END
      CLOSE @Orphans_cursor
      DEALLOCATE @Orphans_cursor
       SELECT @ExecStr = N' UPDATE
                DBO.Lists
                SET
                    tp_Modified =@DTM 
                WHERE
                    tp_WebID = @WebID AND
                    tp_ID = @ListID AND
                    tp_Modified < @DTM'
        EXEC sp_executesql @ExecStr,
            N'@DTM datetime,@WebID uniqueidentifier,@ListID uniqueidentifier',
            @DTM,@WebID,@ListID
     DROP TABLE #OrphanRecurringEventExceptions
     COMMIT TRAN
    END
    RETURN 0

GO
