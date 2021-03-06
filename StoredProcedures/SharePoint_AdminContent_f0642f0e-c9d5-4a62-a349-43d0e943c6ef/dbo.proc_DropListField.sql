/****** Object:  StoredProcedure [dbo].[proc_DropListField]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropListField(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @FieldId uniqueidentifier,
    @ColName nvarchar(64),
    @RowOrdinal int,
    @ColName2 nvarchar(64),
    @RowOrdinal2 int,
    @Fields ntext,
    @ContentTypes ntext,
    @Version int
)
AS
    SET NOCOUNT ON
    DECLARE @guidT uniqueidentifier
    SELECT
        @guidT = tp_Id
    FROM
        Lists WITH(XLOCK)
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId
    IF @ColName IS NOT NULL
    BEGIN         
        EXEC proc_DropUserField @SiteId, @ListId, @FieldId, @ColName, @RowOrdinal
    END
    IF @ColName2 IS NOT NULL
    BEGIN
        EXEC proc_DropUserField @SiteId, @ListId, @FieldId, @ColName2, @RowOrdinal2
    END
    EXEC proc_RemoveListFieldLinks @SiteId, @WebId, @ListId, @FieldId
    DECLARE @Result int
    EXEC @Result = proc_UpdateListFields 
        @SiteId, @WebId, @ListId, @Fields, @ContentTypes, @Version, 1, @FieldId
    RETURN @Result

GO
