/****** Object:  StoredProcedure [dbo].[proc_UpdateItemInNameValuePairByUrl]    Script Date: 5/15/2018 12:13:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateItemInNameValuePairByUrl(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
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
    @SelectFromUserData bit = 0)
AS
    SET NOCOUNT ON
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @iRet int
    SELECT
        @ListId = tp_ListId,
        @ItemId = tp_ID
    FROM
        UserData
    WHERE
        tp_SiteId = @SiteId AND
        tp_DirName = @DirName AND
        tp_LeafName = @LeafName AND
        tp_Level = @Level AND
        tp_RowOrdinal = 0
    EXEC @iRet = proc_UpdateItemInNameValuePair
        @SiteId, NULL, @ListId, @ItemId, @Level,
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
        0,
        @SelectFromUserData
    RETURN @iRet

GO
