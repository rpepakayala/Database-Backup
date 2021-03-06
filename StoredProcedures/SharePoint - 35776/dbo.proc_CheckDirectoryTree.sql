/****** Object:  StoredProcedure [dbo].[proc_CheckDirectoryTree]    Script Date: 5/15/2018 12:11:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CheckDirectoryTree(
    @SiteId uniqueidentifier,
    @FullUrl nvarchar(260),
    @NewFullUrl nvarchar(260),
    @UserId int,
    @WantFlags int,
    @FailedDirName nvarchar(256) = NULL OUTPUT,
    @FailedLeafName nvarchar(128) = NULL OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @UrlLike nvarchar(1024)
    DECLARE @NewDirName nvarchar(256)
    DECLARE @NewLeafName nvarchar(128)
    DECLARE @MaxDataLengthDirName int
    DECLARE @MaxDataLengthFullUrl int
    DECLARE @ListId uniqueidentifier
    DECLARE @DocId uniqueidentifier
    DECLARE @WebId uniqueidentifier
    DECLARE @Type int
    DECLARE @Now datetime
    DECLARE @ReturnStatus int
    DECLARE @HasFlags int
    EXEC proc_SplitUrl
        @FullUrl,
        @DirName OUTPUT,
        @LeafName OUTPUT
    EXEC proc_EscapeForLike @FullUrl, @UrlLike OUTPUT
    EXEC proc_SplitUrl
        @NewFullUrl,
        @NewDirName OUTPUT,
        @NewLeafName OUTPUT
    SET @MaxDataLengthFullUrl = 260 - DATALENGTH(@FullUrl)/2 +
        DATALENGTH(@NewFullUrl)/2
    SET @MaxDataLengthDirName = 256 - DATALENGTH(@DirName)/2 +
        DATALENGTH(@NewDirName)/2
    DECLARE @WantContainedLists bit
    DECLARE @WantContainedWebs bit
    DECLARE @WantCheckedOutDocs bit
    DECLARE @WantPrivateFixup bit
    DECLARE @WantShortermCheckedOutDocsOnly bit
    DECLARE @WantLongPathNames bit
    SET @WantContainedLists = CASE
        WHEN
            (@WantFlags & 0x0020) =
            0x0020
        THEN
            1
        ELSE
            0
        END
    SET @WantContainedWebs  = CASE
        WHEN
            (@WantFlags & 0x0080) =
            0x0080
        THEN
            1
        ELSE
            0
        END
    SET @WantCheckedOutDocs = CASE
        WHEN
            (@WantFlags & 0x0008) =
            0x0008
        THEN
            1
        ELSE
            0
        END
    SET @WantShortermCheckedOutDocsOnly = CASE
        WHEN
            (@WantFlags & 0x0010) =
            0x0010
        THEN
            1
        ELSE
            0
        END
    SET @WantPrivateFixup   = CASE
        WHEN
            (@WantFlags & 0x0002) =
            0x0002
        THEN
            1
        ELSE
            0
        END
    SET @WantLongPathNames = CASE
        WHEN
            (@WantFlags & 0x0100) =
            0x0100
        THEN
            1
        ELSE
            0
        END
    SET @HasFlags = 0
    SET @ReturnStatus = 0
    SET @FailedDirName = NULL
    SET @FailedLeafName = NULL
    SELECT @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    SELECT TOP 1
        @ListId = Docs.ListID,
        @WebId = Docs.WebId
    FROM 
        Docs WITH (NOLOCK)
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName
    IF @ListId IS NOT NULL
    BEGIN
        SELECT
            @ListId = Lists.tp_Id
        FROM
            Lists WITH(UPDLOCK)
        WHERE
            Lists.tp_WebId = @WebId AND
            Lists.tp_Id = @ListId        
    END
    SELECT TOP 1
        @DocId = Docs.Id,
        @WebId = Docs.WebId,
        @Type = Docs.Type,
        @HasFlags =
        (
            CASE
            WHEN
                @WantCheckedOutDocs = 0 AND @WantShortermCheckedOutDocsOnly = 0
            THEN 
                0
            WHEN
                @WantCheckedOutDocs = 1 AND
                ( Docs.CheckoutUserId IS NOT NULL
                AND (Docs.CheckoutUserId <> @UserId OR
                    @UserId IS NULL)
                AND (Docs.CheckoutExpires IS NULL
                OR Docs.CheckoutExpires > @Now))
            THEN
                0x0008
            WHEN
                  @WantShortermCheckedOutDocsOnly = 1 AND
                (Docs.CheckoutUserId IS NOT NULL
                AND (Docs.CheckoutUserId <> @UserId OR
                    @UserId IS NULL)
                AND Docs.CheckoutExpires IS  NOT NULL
                AND  Docs.CheckoutExpires > @Now)
            THEN 
                0x0010
            ELSE
                0
            END |
            CASE
            WHEN
                @WantPrivateFixup = 0
            THEN 
                0
            WHEN
                (Docs.DocFlags &
                    16) =
                    16
            THEN
                0x0002
            ELSE
                0
            END |
            CASE
            WHEN
                (DATALENGTH(Docs.DirName) / 2) > @MaxDataLengthDirName OR
                (DATALENGTH(CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END) / 2) >
                    @MaxDataLengthFullUrl
            THEN
                0x0100
            ELSE
                0
            END
        )
    FROM
        Docs WITH (UPDLOCK)
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName
    IF @Type = 1 AND @ListId IS NOT NULL AND
        @WantContainedLists = 1
    BEGIN
        SELECT
            @HasFlags = CASE WHEN EXISTS (SELECT *
        FROM
            Lists
        WHERE
            tp_WebId = @WebId AND
            tp_ID = @ListId AND
            tp_RootFolder = @DocId)
        THEN @HasFlags | 0x0020 ELSE @HasFlags END
    END
    IF @HasFlags <> 0
    BEGIN
        SET @FailedDirName = @DirName
        SET @FailedLeafName = @LeafName
        GOTO CLEANUP
    END
    IF @Type = 0
    BEGIN
        GOTO CLEANUP
    END
    SELECT @HasFlags = ContainedDocs.HasFlags,
        @FailedDirName = ContainedDocs.DirName,
        @FailedLeafName = ContainedDocs.LeafName
    FROM
    (
    SELECT TOP 1
        (  
            CASE
            WHEN
                @WantContainedLists = 0
            THEN
                0
            WHEN
                Lists.tp_ID IS NOT NULL
            THEN
                0x0020
            ELSE
                0
            END |
            CASE
            WHEN
                @WantContainedWebs = 0
            THEN
                0
            WHEN
                Docs.WebId <> @WebId
            THEN
                0x0080
            ELSE
                0
            END |
            CASE
            WHEN
                @WantCheckedOutDocs = 0 AND @WantShortermCheckedOutDocsOnly = 0
            THEN 
                0
            WHEN
                @WantCheckedOutDocs = 1 AND
                ( Docs.CheckoutUserId IS NOT NULL
                AND (Docs.CheckoutUserId <> @UserId OR
                    @UserId IS NULL)
                AND (Docs.CheckoutExpires IS NULL
                OR Docs.CheckoutExpires > @Now))
            THEN
                0x0008
            WHEN
                  @WantShortermCheckedOutDocsOnly = 1 AND
                (Docs.CheckoutUserId IS NOT NULL
                AND (Docs.CheckoutUserId <> @UserId OR
                    @UserId IS NULL)
                AND Docs.CheckoutExpires IS  NOT NULL
                AND  Docs.CheckoutExpires > @Now)
            THEN 
                0x0010
            ELSE
                0
            END|
            CASE
            WHEN
                @WantPrivateFixup = 0
            THEN
                0
            WHEN
                (Docs.DocFlags & 16) =
                    16
            THEN
                0x0002
            ELSE
                0
            END |
            CASE
            WHEN
                (DATALENGTH(Docs.DirName) / 2) > @MaxDataLengthDirName OR
                (DATALENGTH(CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END) / 2) >
                    @MaxDataLengthFullUrl
            THEN
                0x0100
            ELSE
                0
            END
        ) AS HasFlags,
        Docs.DirName AS DirName,
        Docs.LeafName AS LeafName
    FROM
        Docs WITH (UPDLOCK)
    LEFT OUTER LOOP JOIN
        Lists WITH (NOLOCK)
    ON
        Docs.WebId = Lists.tp_WebId AND
        Docs.Id = Lists.tp_RootFolder AND
        Docs.ListId = Lists.tp_ID
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @FullUrl
    ORDER BY
        HasFlags DESC, DirName, LeafName, Level
    ) AS ContainedDocs
    WHERE
        HasFlags <> 0
    OPTION (FORCE ORDER)
    IF @HasFlags <> 0
    BEGIN
        GOTO CLEANUP
    END
    SELECT @HasFlags = ContainedDocs.HasFlags,
        @FailedDirName = ContainedDocs.DirName,
        @FailedLeafName = ContainedDocs.LeafName
    FROM
    (
    SELECT TOP 1
        (  
            CASE
            WHEN
                @WantContainedLists = 0
            THEN
                0
            WHEN
                Lists.tp_ID IS NOT NULL
            THEN
                0x0020
            ELSE
                0
            END |
            CASE
            WHEN
                @WantContainedWebs = 0
            THEN
                0
            WHEN
                Docs.WebId <> @WebId
            THEN
                0x0080
            ELSE
                0
            END |
            CASE
            WHEN
                @WantCheckedOutDocs = 0 AND @WantShortermCheckedOutDocsOnly = 0
            THEN 
                0
            WHEN
                @WantCheckedOutDocs = 1 AND
                ( Docs.CheckoutUserId IS NOT NULL
                AND (Docs.CheckoutUserId <> @UserId OR
                    @UserId IS NULL)
                AND (Docs.CheckoutExpires IS NULL
                OR Docs.CheckoutExpires > @Now))
            THEN
                0x0008
            WHEN
                  @WantShortermCheckedOutDocsOnly = 1 AND
                (Docs.CheckoutUserId IS NOT NULL
                AND (Docs.CheckoutUserId <> @UserId OR
                    @UserId IS NULL)
                AND Docs.CheckoutExpires IS  NOT NULL
                AND  Docs.CheckoutExpires > @Now)
            THEN 
                0x0010
            ELSE
                0
            END |
            CASE
            WHEN
                @WantPrivateFixup = 0
            THEN
                0
            WHEN
                (Docs.DocFlags & 16) =
                    16
            THEN
                0x0002
            ELSE
                0
            END
        ) AS HasFlags,
        Docs.DirName AS DirName,
        Docs.LeafName AS LeafName
    FROM
        Docs WITH (UPDLOCK)
    LEFT OUTER LOOP JOIN
        Lists WITH (NOLOCK)
    ON
        Docs.WebId = Lists.tp_WebId AND
        Docs.Id = Lists.tp_RootFolder AND
        Docs.ListId = Lists.tp_ID
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName LIKE @UrlLike
    ORDER BY
        HasFlags DESC, DirName, LeafName, Level
    ) AS ContainedDocs
    WHERE
        HasFlags <> 0
    OPTION (FORCE ORDER)
    IF @HasFlags <> 0
    BEGIN
        GOTO CLEANUP
    END
CLEANUP:
    IF @WantFlags & @HasFlags & 0x0080 = 0x0080
    BEGIN
        SET @ReturnStatus =  161
    END
    IF @WantFlags & @HasFlags & 0x0020 = 0x0020
    BEGIN
        SET @ReturnStatus = 138
    END
    IF @WantFlags & @HasFlags & 0x0008 = 0x0008 OR
        @WantFlags & @HasFlags & 0x0010 = 0x0010
    BEGIN
        SET @ReturnStatus = 33
    END
    IF @WantFlags & @HasFlags & 0x0100 = 0x0100
    BEGIN
        SET @ReturnStatus = 206
    END
    RETURN @ReturnStatus

GO
