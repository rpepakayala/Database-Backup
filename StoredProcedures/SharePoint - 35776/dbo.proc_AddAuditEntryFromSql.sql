/****** Object:  StoredProcedure [dbo].[proc_AddAuditEntryFromSql]    Script Date: 5/15/2018 12:11:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddAuditEntryFromSql(
    @SiteId             uniqueidentifier,
    @DirName            nvarchar(256),
    @LeafName           nvarchar(128),
    @ItemType           smallint,
    @UserId             int,
    @Event              int,
    @EventData          ntext = NULL,
    @EventFlag          int)
AS
    SET NOCOUNT ON
    DECLARE @Now datetime        
    DECLARE @FullUrl nvarchar(260)
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END      
    EXEC proc_AddAuditEntryUrl
            @SiteId,
            @DirName,
            @LeafName,
            @ItemType,
            @UserId,
            NULL,
            NULL,
            @FullUrl,
            0,
            @Now,
            @Event,
            NULL,
            0,
            NULL,
            @EventData,
            @EventFlag
     RETURN 0

GO
