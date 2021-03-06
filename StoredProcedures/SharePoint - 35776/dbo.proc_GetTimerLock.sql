/****** Object:  StoredProcedure [dbo].[proc_GetTimerLock]    Script Date: 5/15/2018 12:12:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetTimerLock(
    @WebServer nvarchar(255),
    @LockTimeout int,
    @LockStatus int OUTPUT,
    @OverrideWebServer nvarchar(255) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @LockedWebServer nvarchar(255)
    DECLARE @LockedTime datetime;
    DECLARE @Now datetime
    DECLARE @ID int
    SELECT @Now = GETUTCDATE();
    SELECT @ID = 1
    SELECT @OverrideWebServer = N''
    SELECT
        @LockedWebServer = LockedBy,
        @LockedTime = LockedTime
    FROM
        TimerLock
    WHERE
        ID = @ID
    IF @@ROWCOUNT > 1 OR @@ERROR <> 0
    BEGIN
        SET @LockStatus = 4
        RETURN 167
    END
    IF @LockedWebServer IS NULL AND @LockedTime IS NULL
    BEGIN
        INSERT INTO
            TimerLock(
            ID,
            LockedBy,
            LockedTime)
        VALUES (
            @ID,
            @WebServer,
            @Now)
        IF @@ROWCOUNT = 1
        BEGIN
            SET @LockStatus = 2
            RETURN 0
        END
        ELSE
        BEGIN
            SET @LockStatus = 1
            RETURN 0;
        END
    END
    ELSE
    BEGIN
        UPDATE
            TimerLock
        SET
            LockedBy = @WebServer,
            LockedTime = @Now
        WHERE
            ID = @ID AND
            LockedBy = @LockedWebServer AND
            LockedTime = @LockedTime AND
            (LockedBy = @WebServer OR
                DATEADD(minute, @LockTimeout, @LockedTime) < @Now)
        IF @@ROWCOUNT = 1 AND @LockedWebServer <> @WebServer
        BEGIN
            SET @OverrideWebServer = @LockedWebServer
            SET @LockStatus = 3
            RETURN 0
        END
        ELSE IF @LockedWebServer = @WebServer
        BEGIN
            SET @LockStatus = 2
            RETURN 0
        END
        ELSE
        BEGIN
            SET @LockStatus = 1
            RETURN 0
        END
    END
    RETURN 167 

GO
