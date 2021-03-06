/****** Object:  StoredProcedure [dbo].[proc_DeleteAttachmentsFolder]    Script Date: 5/15/2018 12:11:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteAttachmentsFolder(
    @SiteId      uniqueidentifier,
    @WebId       uniqueidentifier,
    @ListId      uniqueidentifier,
    @UserId      int)
AS
    DECLARE @iRet                 int
    DECLARE @AttachmentsFolderUrl nvarchar(260)
    SELECT @AttachmentsFolderUrl = 
        CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END + N'/' + N'Attachments'
    FROM 
        Docs, Lists
    WHERE
        Lists.tp_WebId      = @WebId AND
        Lists.tp_ID         = @ListId AND
        Lists.tp_RootFolder = Docs.Id
    BEGIN TRAN
    EXEC @iRet = proc_DeleteUrl @SiteId, @WebId, @AttachmentsFolderUrl, 
        @UserId, 1, 0, 0, 0, 0, 1, 
        3
    IF 0 <> @iRet AND 3 <> @iRet
    BEGIN
        GOTO cleanup
    END
    UPDATE 
        UserData 
    SET 
        tp_HasAttachment = 0
    WHERE
        tp_HasAttachment <> 0 AND 
        tp_ListID = @ListId AND
        tp_RowOrdinal = 0
    SET @iRet = 0
cleanup:
    IF (@iRet <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @iRet

GO
