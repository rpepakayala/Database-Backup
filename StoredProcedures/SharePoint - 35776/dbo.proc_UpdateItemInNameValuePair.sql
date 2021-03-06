/****** Object:  StoredProcedure [dbo].[proc_UpdateItemInNameValuePair]    Script Date: 5/15/2018 12:12:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateItemInNameValuePair(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ItemId int,
    @Level tinyint = 1,
    @FieldId1 uniqueidentifier = NULL,
    @FieldValue1 sql_variant = NULL,
    @FieldId2 uniqueidentifier = NULL,
    @FieldValue2 sql_variant = NULL,
    @FieldId3 uniqueidentifier = NULL,
    @FieldValue3 sql_variant = NULL,
    @FieldId4 uniqueidentifier = NULL,
    @FieldValue4 sql_variant = NULL,
    @FieldId5 uniqueidentifier = NULL,
    @FieldValue5 sql_variant = NULL,
    @FieldId6 uniqueidentifier = NULL,
    @FieldValue6 sql_variant = NULL,
    @FieldId7 uniqueidentifier = NULL,
    @FieldValue7 sql_variant = NULL,
    @FieldId8 uniqueidentifier = NULL,
    @FieldValue8 sql_variant = NULL,
    @FieldId9 uniqueidentifier = NULL,
    @FieldValue9 sql_variant = NULL,
    @FieldId10 uniqueidentifier = NULL,
    @FieldValue10 sql_variant = NULL,
    @InsertIfUpdateFails int = 0,
    @SelectFromUserData bit = 0)
AS
    SET NOCOUNT ON
    DECLARE @ReturnCode int
    SET @ReturnCode = 0
    DECLARE @Author int
    DECLARE @Editor int
    DECLARE @Created datetime
    DECLARE @Modified datetime
    DECLARE @HasCopyDestinations bit
    DECLARE @UIVersion int
    DECLARE @ContentTypeId tContentTypeId
    DECLARE @CheckoutUser int
    IF @SelectFromUserData = 1
    BEGIN
        SELECT
            @Author = tp_Author,
            @Editor = tp_Editor,
            @Created = tp_Created,
            @Modified = tp_Modified,
            @HasCopyDestinations = tp_HasCopyDestinations,
            @UIVersion = tp_UIVersion,
            @ContentTypeId = tp_ContentTypeId,
            @CheckoutUser = tp_CheckoutUserId
        FROM
            UserData
        WHERE
            tp_ListID = @ListId AND
            tp_ID = @ItemId AND
            tp_Level = @Level AND
            tp_RowOrdinal = 0
    END
    DECLARE @RowsAffected int
    SET @RowsAffected = 0
    UPDATE
        NVP
    SET
        NVP.Value = NameValuePairEntries.Value
    FROM
        (
        SELECT
            @FieldId1 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue1
                ELSE
                    CASE @FieldId1
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue1
                    END
            END
            AS Value
        WHERE @FieldId1 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId2 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue2
                ELSE
                    CASE @FieldId2
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue2
                    END
            END
            AS Value
        WHERE @FieldId2 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId3 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue3
                ELSE
                    CASE @FieldId3
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue3
                    END
            END
            AS Value
        WHERE @FieldId3 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId4 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue4
                ELSE
                    CASE @FieldId4
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue4
                    END
            END
            AS Value
        WHERE @FieldId4 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId5 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue5
                ELSE
                    CASE @FieldId5
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue5
                    END
            END
            AS Value
        WHERE @FieldId5 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId6 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue6
                ELSE
                    CASE @FieldId6
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue6
                    END
            END
            AS Value
        WHERE @FieldId6 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId7 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue7
                ELSE
                    CASE @FieldId7
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue7
                    END
            END
            AS Value
        WHERE @FieldId7 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId8 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue8
                ELSE
                    CASE @FieldId8
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue8
                    END
            END
            AS Value
        WHERE @FieldId8 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId9 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue9
                ELSE
                    CASE @FieldId9
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue9
                    END
            END
            AS Value
        WHERE @FieldId9 IS NOT NULL
        UNION ALL
        SELECT
            @FieldId10 AS FieldId,
            CASE @SelectFromUserData
                WHEN 0 THEN @FieldValue10
                ELSE
                    CASE @FieldId10
                        WHEN '{1df5e554-ec7e-46a6-901d-d85a3881cb18}' THEN @Author
                        WHEN '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' THEN @Editor
                        WHEN '{8c06beca-0777-48f7-91c7-6da68bc07b69}' THEN @Created
                        WHEN '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' THEN @Modified
                        WHEN '{26d0756c-986a-48a7-af35-bf18ab85ff4a}' THEN @HasCopyDestinations
                        WHEN '{7841bf41-43d0-4434-9f50-a673baef7631}' THEN @UIVersion
                        WHEN '{03e45e84-1992-4d42-9116-26f756012634}' THEN @ContentTypeId
                        WHEN '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' THEN @CheckoutUser
                        ELSE @FieldValue10
                    END
            END
            AS Value
        WHERE @FieldId10 IS NOT NULL
        )
        AS NameValuePairEntries
    INNER JOIN
        NameValuePair NVP
    ON
        NVP.SiteId = @SiteId AND
        NVP.ListId = @ListId AND
        NVP.ItemId = @ItemId AND
        NVP.Level = CASE WHEN @Level IS NULL THEN NVP.Level ELSE @Level END AND
        NVP.FieldId = NameValuePairEntries.FieldId
    SET @RowsAffected = @@RowCount
    IF @RowsAffected = 0
    BEGIN
        IF @InsertIfUpdateFails = 1
        BEGIN
            EXEC @ReturnCode = proc_InsertItemIntoNameValuePair
                @SiteId, @WebId, @ListId, @ItemId, @Level,
                @FieldId1, @FieldValue1,
                @FieldId2, @FieldValue2,
                @FieldId3, @FieldValue3,
                @FieldId4, @FieldValue4,
                @FieldId5, @FieldValue5,
                @FieldId6, @FieldValue6,
                @FieldId7, @FieldValue7,
                @FieldId8, @FieldValue8,
                @FieldId9, @FieldValue9,
                @FieldId10, @FieldValue10,
                @SelectFromUserData
            SET @RowsAffected = @@RowCount
        END
        IF @RowsAffected = 0
        BEGIN
            SET @ReturnCode = 87
            GOTO CLEANUP
        END
    END
CLEANUP:
    RETURN @ReturnCode

GO
