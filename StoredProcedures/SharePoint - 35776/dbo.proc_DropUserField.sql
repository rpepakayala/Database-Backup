/****** Object:  StoredProcedure [dbo].[proc_DropUserField]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropUserField(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @FieldId uniqueidentifier,
    @ColName nvarchar(64),
    @RowOrdinal int)
AS
    SET NOCOUNT ON
    DECLARE @QueryString nvarchar(1024)
    DECLARE @fUpdateSize INT
    DECLARE @DataLengthString nvarchar(1024)
    SET @fUpdateSize = 0
    IF (@ColName LIKE 'nvarchar%' OR
        @ColName LIKE 'ntext%' OR
        @ColName LIKE 'sql_variant%')
    BEGIN
        SET @fUpdateSize = 1
        SET @DataLengthString = 'ISNULL(DATALENGTH(' + @ColName + '), 0)'
        SET @QueryString =
            N'DECLARE @cbDelta bigint 
                SELECT @cbDelta = -SUM(CAST(' + @DataLengthString +
                    ' AS bigint)) 
                FROM DBO.AllUSERDATA WHERE tp_ListId = @P1 AND tp_RowOrdinal = @P3 
                EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                    @P2, @cbDelta, 1'
        EXEC sp_executesql @QueryString,
            N'@P1 uniqueidentifier, @P2 uniqueidentifier, @P3 int', @ListId, @SiteId, @RowOrdinal
    END
    IF (@fUpdateSize = 0)
    BEGIN
        SET @QueryString = 
            N'UPDATE AllUserData SET ' +
                @ColName + ' = NULL WHERE tp_ListId = @P1 AND tp_RowOrdinal = @P2'
    END
    ELSE
    BEGIN
        SET @QueryString =
        N'UPDATE DBO.AllUserData SET tp_Size = CASE 
            WHEN tp_Size > ' + @DataLengthString +
            ' THEN tp_Size - ' + @DataLengthString +
                N'ELSE 0
                    END, ' +
                @ColName + N' = NULL WHERE tp_ListId = @P1 AND tp_RowOrdinal = @P2'
    END
    EXEC sp_executesql @QueryString, N'@P1 uniqueidentifier, @P2 int', @ListId, @RowOrdinal
    DELETE NVP FROM
        NameValuePair AS NVP
    WHERE
        SiteId = @SiteId AND
        ListId = @ListId AND
        FieldId = @FieldId
    DECLARE @Collation smallint
    EXEC proc_GetCollation @ListId, @Collation OUTPUT
    IF @Collation = 0
    BEGIN
        DELETE NVP FROM
            NameValuePair_Albanian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 1
    BEGIN
        DELETE NVP FROM
            NameValuePair_Arabic_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 2
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 3
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 4
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 5
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 6
    BEGIN
        DELETE NVP FROM
            NameValuePair_Croatian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 7
    BEGIN
        DELETE NVP FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 8
    BEGIN
        DELETE NVP FROM
            NameValuePair_Czech_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 9
    BEGIN
        DELETE NVP FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 10
    BEGIN
        DELETE NVP FROM
            NameValuePair_Estonian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 11
    BEGIN
        DELETE NVP FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 12
    BEGIN
        DELETE NVP FROM
            NameValuePair_French_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 13
    BEGIN
        DELETE NVP FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 14
    BEGIN
        DELETE NVP FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 15
    BEGIN
        DELETE NVP FROM
            NameValuePair_Greek_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 16
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 17
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hindi_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 18
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 19
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 20
    BEGIN
        DELETE NVP FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 21
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 22
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 23
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 24
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 25
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 26
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latvian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 27
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 28
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 29
    BEGIN
        DELETE NVP FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 30
    BEGIN
        DELETE NVP FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 31
    BEGIN
        DELETE NVP FROM
            NameValuePair_Polish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 32
    BEGIN
        DELETE NVP FROM
            NameValuePair_Romanian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 33
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovak_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 34
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 35
    BEGIN
        DELETE NVP FROM
            NameValuePair_Thai_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 36
    BEGIN
        DELETE NVP FROM
            NameValuePair_Turkish_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 37
    BEGIN
        DELETE NVP FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    ELSE
    IF @Collation = 38
    BEGIN
        DELETE NVP FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        WHERE SiteId = @SiteId AND ListId = @ListId AND FieldId = @FieldId
    END
    EXEC proc_DropUserDataJunctions @SiteId, @ListId, @FieldId

GO
