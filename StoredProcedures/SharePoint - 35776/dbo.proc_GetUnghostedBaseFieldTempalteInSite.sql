/****** Object:  StoredProcedure [dbo].[proc_GetUnghostedBaseFieldTempalteInSite]    Script Date: 5/15/2018 12:12:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_GetUnghostedBaseFieldTempalteInSite(
    @SiteId uniqueidentifier,
    @Scope nvarchar(256),
    @FieldId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @ctid tContentTypeId
    SET @ctid = CAST(@FieldId AS varbinary(16))
    SELECT
        @FieldId,
        Definition
    FROM
        ContentTypes
    WHERE
        SiteId = @SiteId AND
        Class = 0 AND
        Scope = @Scope AND
        ContentTypeId = @ctid

GO
