/****** Object:  StoredProcedure [dbo].[proc_AL]    Script Date: 5/15/2018 12:12:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AL( 
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint,
    @LinkNumber int,
    @TargetDirName nvarchar(256),
    @TargetLeafName nvarchar(128),
    @Type tinyint,
    @Security tinyint,
    @Dynamic tinyint,
    @ServerRel bit,
    @Search ntext,
    @WP uniqueidentifier = NULL, 
    @Fld uniqueidentifier = NULL) 
AS
    SET NOCOUNT ON
    BEGIN TRAN
    DECLARE @PointsToDir bit
    SET @PointsToDir = 0
    IF (@ServerRel = 1)
    BEGIN
        IF (DATALENGTH(@TargetLeafName) = 0)
        BEGIN
            SELECT
                @TargetLeafName = WelcomeName 
            FROM 
                fn_GetWelcomeName(@SiteId, @TargetDirName)
            IF @TargetLeafName IS NOT NULL
            BEGIN
                SET @PointsToDir = 1
            END
        END
        ELSE
        BEGIN
            DECLARE @GhostDir bit
            DECLARE @TmpType tinyint
            DECLARE @TmpTargetDirName nvarchar(256)
            DECLARE @TmpTargetLeafName nvarchar(128)
            SELECT 
                @TmpType = Type
            FROM
                Docs
            WHERE
                SiteId = @SiteId AND
                DirName = @TargetDirName AND
                LeafName = @TargetLeafName
            IF (@@ROWCOUNT = 0 AND
                CHARINDEX(N'.',
                @TargetLeafName COLLATE Latin1_General_BIN) = 0)
            BEGIN
                SET @GhostDir = 1
            END
            ELSE
            BEGIN
                SET @GhostDir = 0
            END
            IF (@TmpType = 1 OR @GhostDir = 1)
            BEGIN
                SET @TmpTargetDirName = 
                CASE 
                WHEN 
                    NOT (DATALENGTH(@TargetDirName) = 0) AND
                    NOT (DATALENGTH(@TargetLeafName) = 0)
                THEN
                    @TargetDirName + N'/' + @TargetLeafName
                ELSE
                    @TargetDirName + @TargetLeafName
                END
                SELECT
                    @TmpTargetLeafName = WelcomeName 
                FROM 
                    fn_GetWelcomeName(@SiteId, @TmpTargetDirName)
                IF (@@ROWCOUNT <> 0)
                BEGIN
                    SET @TargetDirName = @TmpTargetDirName
                    SET @TargetLeafName = @TmpTargetLeafName
                    SET @PointsToDir = 1
                END
            END
        END
    END
    INSERT INTO Links (
        SiteId,
        DirName,
        LeafName,
        Level,
        WebPartId,
        FieldId,
        LinkNumber,
        TargetDirName,
        TargetLeafName,
        Type,
        Security,
        Dynamic,
        ServerRel,
        PointsToDir,
        Search)
    VALUES (
        @SiteId,
        @DirName,
        @LeafName,
        @Level,
        @WP, 
        @Fld, 
        @LinkNumber,
        @TargetDirName,
        @TargetLeafName,
        @Type,
        @Security,
        @Dynamic,
        @ServerRel,
        @PointsToDir,
        @Search)
    IF @ServerRel = 1
    BEGIN
        UPDATE
            Docs
        SET
            MetaInfoTimeLastModified =
                dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            Level = @Level
    END
    COMMIT TRAN
    RETURN 0 

GO
