/****** Object:  StoredProcedure [dbo].[proc_TestAttachmentsFlagWritePerm]    Script Date: 5/15/2018 12:12:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_TestAttachmentsFlagWritePerm(
    @SiteID                 uniqueidentifier,
    @DirName                nvarchar(256),
    @LeafName               nvarchar(128),
    @UrlFlag                tinyint,
    @UserID                 int,
    @NeedManageListRight    bit OUTPUT)
AS
    DECLARE @IsAttachment   bit
    DECLARE @WriteSecurity  int
    DECLARE @ListID         uniqueidentifier
    EXEC @IsAttachment = proc_TestAttachmentsFlag 
        @SiteID, 
        @DirName, 
        @UrlFlag, 
        @ListID         OUTPUT,
        NULL,           
        @WriteSecurity  OUTPUT
    IF @IsAttachment = 1
    BEGIN
        IF @WriteSecurity = 0x00000004
            SET @NeedManageListRight = 1
        IF @WriteSecurity = 0x00000002
        BEGIN
            IF @UrlFlag = 1
            BEGIN
                DECLARE @ItemID     nvarchar(128)
                DECLARE @AuthorID   int
                EXEC proc_SplitUrl  @DirName, NULL,  @ItemID OUTPUT
                SELECT @NeedManageListRight = CASE WHEN EXISTS(
                    SELECT *
                    FROM UserData
                    WHERE 
                        tp_ListId = @ListID AND
                        tp_ID     = @ItemID AND
                        tp_RowOrdinal = 0 AND
                        tp_Author = @UserID)
                    THEN 0 ELSE 1 END
            END
        END
    END
    RETURN @IsAttachment    

GO
