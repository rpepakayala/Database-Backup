/****** Object:  StoredProcedure [dbo].[proc_CloneSeedDataForMtgInst]    Script Date: 5/15/2018 12:11:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CloneSeedDataForMtgInst
(
    @SiteId                 uniqueidentifier,
    @WebId                  uniqueidentifier,
    @InstanceID             int,
    @ForAttendees           bit = NULL  
)
AS
    SET NOCOUNT ON
    DECLARE SeedData_cursor CURSOR
        LOCAL
        FAST_FORWARD
    FOR
    SELECT
        UserData.tp_ID,
        UserData.tp_ListId,
        UserData.tp_DirName,
        UserData.tp_LeafName
    FROM
        UserData INNER JOIN Lists
    ON
        UserData.tp_ListId = Lists.tp_ID
    WHERE
        Lists.tp_WebId = @WebId AND
        Lists.tp_BaseType <> 1 AND  
        UserData.tp_RowOrdinal = 0 AND
        (Lists.tp_Flags & 0x20) <> 0 AND  
        UserData.tp_InstanceID = 0 AND   
        (@ForAttendees IS NULL OR
            ((@ForAttendees = 1 AND Lists.tp_ServerTemplate  = 202) OR
                (@ForAttendees = 0 AND Lists.tp_ServerTemplate <> 202)))
    DECLARE @ItemId int
    DECLARE @ListId uniqueidentifier
    DECLARE @NewItemId int
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    OPEN SeedData_cursor
    FETCH NEXT 
    FROM 
        SeedData_cursor
    INTO
        @ItemId,
        @ListId,
        @DirName,
        @LeafName
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC proc_CloneDoc
            @SiteId,
            @DirName,
            @LeafName,
            @InstanceID,
            @NewItemId OUTPUT
        FETCH NEXT 
        FROM 
            SeedData_cursor
        INTO
            @ItemId,
            @ListId,
            @DirName,
            @LeafName
    END
    CLOSE SeedData_cursor
    DEALLOCATE SeedData_cursor
    RETURN 0

GO
