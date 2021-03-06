/****** Object:  StoredProcedure [dbo].[proc_EnumLists]    Script Date: 5/15/2018 12:12:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnumLists(
       @WebId uniqueidentifier,
       @Collation nvarchar(32),
       @BaseType int = NULL,
       @BaseType2 int = NULL,
       @BaseType3 int = NULL,
       @BaseType4 int = NULL,
       @ServerTemplate int = NULL,
       @FMobileDefaultViewUrl bit = NULL,
       @FRootFolder bit = NULL,
       @ListFlags int = NULL,
       @FAclInfo int = NULL,
       @Scopes image = NULL,
       @FRecycleBinInfo bit = NULL,
       @UserId int = NULL)
AS
        SET NOCOUNT ON
        IF @BaseType IS NULL
        BEGIN
           SET @BaseType = -1
        END
        IF @BaseType2 IS NULL
        BEGIN
           SET @BaseType2 = -1
        END
        IF @BaseType3 IS NULL
        BEGIN
           SET @BaseType3 = -1
        END
        IF @BaseType4 IS NULL
        BEGIN
           SET @BaseType4 = -1
        END
        IF @ServerTemplate IS NULL
        BEGIN
            SET @ServerTemplate = -1
        END
        IF @ListFlags IS NULL
        BEGIN
           SET @ListFlags = -1
        END
        DECLARE @WebFullUrl nvarchar(256)
        DECLARE @SiteId uniqueidentifier
        DECLARE @ReturnValue int
        SELECT
            @WebFullUrl = Webs.FullUrl,
            @SiteId = Webs.SiteId
        FROM
            Webs
        WHERE
            Webs.Id = @WebId
        SET @WebFullUrl = N'/' + @WebFullUrl
        IF @Scopes IS NULL
        BEGIN
            EXEC @ReturnValue = proc_EnumListsCoreNoScopes
                @SiteId, @WebId, @WebFullUrl, @Collation, @BaseType,
                @BaseType2, @BaseType3, @BaseType4,
                @ServerTemplate, @FMobileDefaultViewUrl, @FRootFolder, 
                @ListFlags, @FAclInfo
        END
        ELSE
        BEGIN
            EXEC @ReturnValue = proc_EnumListsCoreWithScopes
                @SiteId, @WebId, @WebFullUrl, @Collation, @BaseType,
                @BaseType2, @BaseType3, @BaseType4,
                @ServerTemplate, @FMobileDefaultViewUrl, @FRootFolder, 
                @ListFlags, @FAclInfo, @Scopes
        END
        IF (@FRecycleBinInfo = 1)
        BEGIN
            DECLARE @RecycleCount int
            DECLARE @RecycleSize bigint
            SET @RecycleCount = 0
            SET @RecycleSize = 0
            EXEC proc_GetRecycleBinInfo
                @SiteId,
                @WebId,
                @UserId,
                @RecycleCount OUTPUT,
                @RecycleSize OUTPUT
            SELECT
                @RecycleCount,
                @RecycleSize
        END
        ELSE
        BEGIN
            SELECT
                NULL
            WHERE
                1 = 0
        END
        RETURN @ReturnValue

GO
