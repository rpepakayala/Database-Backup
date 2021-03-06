/****** Object:  StoredProcedure [dbo].[proc_InsertItemIntoNameValuePairCollated]    Script Date: 5/15/2018 12:12:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_InsertItemIntoNameValuePairCollated(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ItemId int,
    @Collation smallint,
    @Level tinyint = 1,
    @FieldId1 uniqueidentifier = NULL,
    @FieldValue1 nvarchar(255) = NULL,
    @FieldId2 uniqueidentifier = NULL,
    @FieldValue2 nvarchar(255) = NULL,
    @FieldId3 uniqueidentifier = NULL,
    @FieldValue3 nvarchar(255) = NULL,
    @FieldId4 uniqueidentifier = NULL,
    @FieldValue4 nvarchar(255) = NULL,
    @FieldId5 uniqueidentifier = NULL,
    @FieldValue5 nvarchar(255) = NULL,
    @FieldId6 uniqueidentifier = NULL,
    @FieldValue6 nvarchar(255) = NULL,
    @FieldId7 uniqueidentifier = NULL,
    @FieldValue7 nvarchar(255) = NULL,
    @FieldId8 uniqueidentifier = NULL,
    @FieldValue8 nvarchar(255) = NULL,
    @FieldId9 uniqueidentifier = NULL,
    @FieldValue9 nvarchar(255) = NULL,
    @FieldId10 uniqueidentifier = NULL,
    @FieldValue10 nvarchar(255) = NULL)
AS
    SET NOCOUNT ON
    DECLARE @ReturnCode int
    SET @ReturnCode = 0
    DECLARE @RowsAffected int
    SET @RowsAffected = 0
    DECLARE @NameValuePairEntries TABLE (
        FieldId uniqueidentifier,
        Value nvarchar(255))
    INSERT INTO @NameValuePairEntries
        SELECT
            @FieldId1 AS FieldId,
            @FieldValue1 AS Value
        WHERE @FieldId1 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId2 AS FieldId,
            @FieldValue2 AS Value
        WHERE @FieldId2 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId3 AS FieldId,
            @FieldValue3 AS Value
        WHERE @FieldId3 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId4 AS FieldId,
            @FieldValue4 AS Value
        WHERE @FieldId4 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId5 AS FieldId,
            @FieldValue5 AS Value
        WHERE @FieldId5 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId6 AS FieldId,
            @FieldValue6 AS Value
        WHERE @FieldId6 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId7 AS FieldId,
            @FieldValue7 AS Value
        WHERE @FieldId7 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId8 AS FieldId,
            @FieldValue8 AS Value
        WHERE @FieldId8 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId9 AS FieldId,
            @FieldValue9 AS Value
        WHERE @FieldId9 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId10 AS FieldId,
            @FieldValue10 AS Value
        WHERE @FieldId10 IS NOT NULL
    IF @Collation = 0
    BEGIN
        INSERT INTO NameValuePair_Albanian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 1
    BEGIN
        INSERT INTO NameValuePair_Arabic_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 2
    BEGIN
        INSERT INTO NameValuePair_Chinese_PRC_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 3
    BEGIN
        INSERT INTO NameValuePair_Chinese_PRC_Stroke_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 4
    BEGIN
        INSERT INTO NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 5
    BEGIN
        INSERT INTO NameValuePair_Chinese_Taiwan_Stroke_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 6
    BEGIN
        INSERT INTO NameValuePair_Croatian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 7
    BEGIN
        INSERT INTO NameValuePair_Cyrillic_General_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 8
    BEGIN
        INSERT INTO NameValuePair_Czech_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 9
    BEGIN
        INSERT INTO NameValuePair_Danish_Norwegian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 10
    BEGIN
        INSERT INTO NameValuePair_Estonian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 11
    BEGIN
        INSERT INTO NameValuePair_Finnish_Swedish_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 12
    BEGIN
        INSERT INTO NameValuePair_French_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 13
    BEGIN
        INSERT INTO NameValuePair_Georgian_Modern_Sort_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 14
    BEGIN
        INSERT INTO NameValuePair_German_PhoneBook_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 15
    BEGIN
        INSERT INTO NameValuePair_Greek_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 16
    BEGIN
        INSERT INTO NameValuePair_Hebrew_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 17
    BEGIN
        INSERT INTO NameValuePair_Hindi_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 18
    BEGIN
        INSERT INTO NameValuePair_Hungarian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 19
    BEGIN
        INSERT INTO NameValuePair_Hungarian_Technical_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 20
    BEGIN
        INSERT INTO NameValuePair_Icelandic_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 21
    BEGIN
        INSERT INTO NameValuePair_Japanese_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 22
    BEGIN
        INSERT INTO NameValuePair_Japanese_Unicode_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 23
    BEGIN
        INSERT INTO NameValuePair_Korean_Wansung_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 24
    BEGIN
        INSERT INTO NameValuePair_Korean_Wansung_Unicode_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 25
    BEGIN
        INSERT INTO NameValuePair_Latin1_General_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 26
    BEGIN
        INSERT INTO NameValuePair_Latvian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 27
    BEGIN
        INSERT INTO NameValuePair_Lithuanian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 28
    BEGIN
        INSERT INTO NameValuePair_Lithuanian_Classic_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 29
    BEGIN
        INSERT INTO NameValuePair_Traditional_Spanish_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 30
    BEGIN
        INSERT INTO NameValuePair_Modern_Spanish_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 31
    BEGIN
        INSERT INTO NameValuePair_Polish_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 32
    BEGIN
        INSERT INTO NameValuePair_Romanian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 33
    BEGIN
        INSERT INTO NameValuePair_Slovak_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 34
    BEGIN
        INSERT INTO NameValuePair_Slovenian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 35
    BEGIN
        INSERT INTO NameValuePair_Thai_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 36
    BEGIN
        INSERT INTO NameValuePair_Turkish_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 37
    BEGIN
        INSERT INTO NameValuePair_Ukrainian_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    ELSE
    IF @Collation = 38
    BEGIN
        INSERT INTO NameValuePair_Vietnamese_CI_AS(SiteId, WebId, ListId, ItemId, Level, FieldId, Value)
            SELECT
                @SiteId, @WebId, @ListId, @ItemId, @Level, FieldId, Value
            FROM
                @NameValuePairEntries
    END
    SET @RowsAffected = @@RowCount
    IF @RowsAffected = 0
    BEGIN
        SET @ReturnCode = 87
        GOTO CLEANUP
    END
CLEANUP:
    RETURN @ReturnCode

GO
