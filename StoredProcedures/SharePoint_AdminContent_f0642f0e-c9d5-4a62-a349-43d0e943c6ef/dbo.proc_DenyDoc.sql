/****** Object:  StoredProcedure [dbo].[proc_DenyDoc]    Script Date: 5/15/2018 12:12:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DenyDoc(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint OUTPUT,
    @UserId int,
    @MinorVersionEnabled bit,
    @Moderated bit,
    @ModerationStatus int)
AS
    SET NOCOUNT ON
    DECLARE @ListID uniqueidentifier
    DECLARE @ItemId int
    DECLARE @DocId uniqueidentifier
    DECLARE @DocParentId uniqueidentifier
    DECLARE @DraftOwnerId int
    DECLARE @LastUIVersion int
    DECLARE @CurrentUIVersion int
    DECLARE @LTCheckoutUserId int
    DECLARE @FullUrl nvarchar(260)
    IF @Level = 255
        RETURN 0    
    SELECT 
        @ListID = ListId,
        @ItemId = DoclibRowId,
        @DocId = ID,
        @DocParentId = ParentId,
        @DraftOwnerId = DraftOwnerId,
        @CurrentUIVersion = UIVersion,
        @LTCheckoutUserId = LTCheckoutUserId
    FROM 
        Docs
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND 
        Docs.Level = @Level
    IF (@DraftOwnerId IS  NOT NULL AND @Level = 1)
        RETURN 0
    IF @Level = 1
    BEGIN
        IF @MinorVersionEnabled = 1
        BEGIN
            SELECT TOP 1
                @LastUIVersion = Version
            FROM 
                AllDocVersions
            WHERE 
                AllDocVersions.Id = @DocId AND
                AllDocVersions.SiteId = @SiteId
            ORDER BY
                Version DESC
            IF @LastUIVersion IS NULL OR
                @LastUIVersion < @CurrentUIVersion-512
            BEGIN
              SET @LastUIVersion = @CurrentUIVersion-512          
            END
            SET @CurrentUIVersion = @LastUIVersion+1
        END        
    END
    IF (@ListID IS NOT NULL) AND (@ItemId IS NOT NULL)
    BEGIN
        UPDATE 
            UserData
        SET
            tp_Level = 2,             
            tp_UIVersion = @CurrentUIVersion,   
            tp_ModerationStatus = @ModerationStatus,
            tp_DraftOwnerId = @UserId
        WHERE
            UserData.tp_SiteId = @SiteId AND
            UserData.tp_ListId = @ListID AND
            UserData.tp_ID = @ItemId AND
            UserData.tp_Level = @Level
        UPDATE
            NVP
        SET
            Level = 2
        FROM
            NameValuePair AS NVP
        WHERE
            SiteId = @SiteId AND
            ListId = @ListID AND
            ItemId = @ItemId AND
            Level = @Level
        DECLARE @Collation smallint
        EXEC proc_GetCollation @ListId, @Collation OUTPUT
    IF @Collation = 0
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Albanian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 1
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Arabic_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 2
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 3
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 4
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 5
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 6
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Croatian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 7
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 8
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Czech_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 9
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 10
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Estonian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 11
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 12
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_French_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 13
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 14
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 15
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Greek_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 16
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 17
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Hindi_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 18
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 19
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 20
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 21
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Japanese_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 22
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 23
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 24
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 25
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 26
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Latvian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 27
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 28
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 29
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 30
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 31
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Polish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 32
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Romanian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 33
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Slovak_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 34
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 35
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Thai_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 36
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Turkish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 37
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
    ELSE
    IF @Collation = 38
    BEGIN
        UPDATE NVP SET Level = 2 FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListID AND ItemId = @ItemId AND Level = @Level
    END
        EXEC proc_UpdateItemInNameValuePair
            @SiteId, NULL, @ListId, @ItemID, 2,
            '{7841bf41-43d0-4434-9f50-a673baef7631}', @CurrentUIVersion
        IF @LTCheckoutUserId IS NOT NULL
        BEGIN
            UPDATE 
                UserData
            SET
                tp_DraftOwnerId = @UserId,
                tp_ModerationStatus = @ModerationStatus
            WHERE
                UserData.tp_SiteId = @SiteId AND
                UserData.tp_ListId = @ListID AND
                UserData.tp_ID = @ItemId AND
                UserData.tp_Level = 255
        END
    END
    UPDATE
        Docs
    SET 
        Level = 2,                    
        Version = Version + 1,
        DraftOwnerId = @UserId,
        UIVersion = @CurrentUIVersion           
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.Level = @Level
    IF @LTCheckoutUserId IS NOT NULL
    BEGIN
        UPDATE
            Docs
        SET 
            DraftOwnerId = @UserId
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND
            Docs.Level = 255
    END
    UPDATE
        DocStreams
    SET 
        Level = 2
    WHERE
        DocStreams.SiteId = @SiteId AND
        DocStreams.ParentId = @DocParentId AND
        DocStreams.Id = @DocId AND
        DocStreams.Level = @Level
    SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    UPDATE
        Deps
    SET
        Level =  2
    WHERE
        SiteId = @SiteId AND
        DeleteTransactionId = 0x AND
        FullUrl = @FullUrl AND
        Level = @Level
    UPDATE     
        Links
    SET
        Level =  2
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level
    UPDATE 
        WebParts
    SET
        tp_Level = 2
    WHERE
        tp_SiteId = @SiteId AND
        tp_PageUrlId = @DocId AND
        tp_Level = @Level
    EXEC proc_ChangeJunctionLevel
        @SiteId,
        @DirName,
        @LeafName,
        @Level,
        2
    SET @Level = 2
    RETURN 0

GO
