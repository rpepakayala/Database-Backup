/****** Object:  StoredProcedure [dbo].[proc_DeleteFromNVP]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteFromNVP(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier = NULL,
    @ItemId int = NULL,
    @Level tinyint = NULL)
AS
    SET NOCOUNT ON
    IF @ListId IS NULL
    BEGIN
        DELETE FROM
            NameValuePair_Albanian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Arabic_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Chinese_PRC_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Croatian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Cyrillic_General_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Czech_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Danish_Norwegian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Estonian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Finnish_Swedish_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_French_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_German_PhoneBook_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Greek_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Hebrew_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Hindi_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Hungarian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Hungarian_Technical_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Icelandic_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Japanese_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Japanese_Unicode_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Korean_Wansung_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Latin1_General_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Latvian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Lithuanian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Lithuanian_Classic_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Traditional_Spanish_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Modern_Spanish_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Polish_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Romanian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Slovak_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Slovenian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Thai_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Turkish_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Ukrainian_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair_Vietnamese_CI_AS
        WHERE
            SiteId = @SiteId
        DELETE FROM
            NameValuePair
        WHERE
            SiteId = @SiteId
    END
    ELSE
    BEGIN
        DECLARE @Collation smallint
        EXEC proc_GetCollation @ListId, @Collation OUTPUT
        DELETE FROM
            NameValuePair
        WHERE
            SiteId = @SiteId AND
            ListId = @ListId AND
            ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
            Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        IF @Collation = 0
        BEGIN
            DELETE FROM
                NameValuePair_Albanian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 1
        BEGIN
            DELETE FROM
                NameValuePair_Arabic_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 2
        BEGIN
            DELETE FROM
                NameValuePair_Chinese_PRC_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 3
        BEGIN
            DELETE FROM
                NameValuePair_Chinese_PRC_Stroke_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 4
        BEGIN
            DELETE FROM
                NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 5
        BEGIN
            DELETE FROM
                NameValuePair_Chinese_Taiwan_Stroke_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 6
        BEGIN
            DELETE FROM
                NameValuePair_Croatian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 7
        BEGIN
            DELETE FROM
                NameValuePair_Cyrillic_General_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 8
        BEGIN
            DELETE FROM
                NameValuePair_Czech_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 9
        BEGIN
            DELETE FROM
                NameValuePair_Danish_Norwegian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 10
        BEGIN
            DELETE FROM
                NameValuePair_Estonian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 11
        BEGIN
            DELETE FROM
                NameValuePair_Finnish_Swedish_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 12
        BEGIN
            DELETE FROM
                NameValuePair_French_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 13
        BEGIN
            DELETE FROM
                NameValuePair_Georgian_Modern_Sort_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 14
        BEGIN
            DELETE FROM
                NameValuePair_German_PhoneBook_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 15
        BEGIN
            DELETE FROM
                NameValuePair_Greek_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 16
        BEGIN
            DELETE FROM
                NameValuePair_Hebrew_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 17
        BEGIN
            DELETE FROM
                NameValuePair_Hindi_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 18
        BEGIN
            DELETE FROM
                NameValuePair_Hungarian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 19
        BEGIN
            DELETE FROM
                NameValuePair_Hungarian_Technical_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 20
        BEGIN
            DELETE FROM
                NameValuePair_Icelandic_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 21
        BEGIN
            DELETE FROM
                NameValuePair_Japanese_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 22
        BEGIN
            DELETE FROM
                NameValuePair_Japanese_Unicode_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 23
        BEGIN
            DELETE FROM
                NameValuePair_Korean_Wansung_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 24
        BEGIN
            DELETE FROM
                NameValuePair_Korean_Wansung_Unicode_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 25
        BEGIN
            DELETE FROM
                NameValuePair_Latin1_General_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 26
        BEGIN
            DELETE FROM
                NameValuePair_Latvian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 27
        BEGIN
            DELETE FROM
                NameValuePair_Lithuanian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 28
        BEGIN
            DELETE FROM
                NameValuePair_Lithuanian_Classic_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 29
        BEGIN
            DELETE FROM
                NameValuePair_Traditional_Spanish_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 30
        BEGIN
            DELETE FROM
                NameValuePair_Modern_Spanish_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 31
        BEGIN
            DELETE FROM
                NameValuePair_Polish_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 32
        BEGIN
            DELETE FROM
                NameValuePair_Romanian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 33
        BEGIN
            DELETE FROM
                NameValuePair_Slovak_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 34
        BEGIN
            DELETE FROM
                NameValuePair_Slovenian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 35
        BEGIN
            DELETE FROM
                NameValuePair_Thai_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 36
        BEGIN
            DELETE FROM
                NameValuePair_Turkish_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 37
        BEGIN
            DELETE FROM
                NameValuePair_Ukrainian_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
        ELSE
        IF @Collation = 38
        BEGIN
            DELETE FROM
                NameValuePair_Vietnamese_CI_AS            WHERE
                SiteId = @SiteId AND
                ListId = @ListId AND
                ItemId = CASE WHEN @ItemId IS NULL THEN ItemId ELSE @ItemId END AND
                Level = CASE WHEN @Level IS NULL THEN Level ELSE @Level END
        END
    END
    RETURN 0

GO
