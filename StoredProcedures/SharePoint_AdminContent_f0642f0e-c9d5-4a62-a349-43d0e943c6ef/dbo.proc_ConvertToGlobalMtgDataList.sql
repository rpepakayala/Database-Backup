/****** Object:  StoredProcedure [dbo].[proc_ConvertToGlobalMtgDataList]    Script Date: 5/15/2018 12:12:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ConvertToGlobalMtgDataList
(
    @SiteId         uniqueidentifier,
    @WebId          uniqueidentifier,
    @ListId         uniqueidentifier,
    @BaseType       int,
    @ServerTemplate int
)
AS
    SET NOCOUNT ON
    IF @BaseType = 1
        RETURN 0
    IF (@ServerTemplate = 200 OR
        @ServerTemplate = 202 OR
        @ServerTemplate = 212)
        RETURN 13
    DECLARE ListSeedData_cursor CURSOR
        LOCAL
        FAST_FORWARD
    FOR
    SELECT
        UserData.tp_ID
    FROM
        UserData
    WHERE
        tp_ListId = @ListId AND
        tp_InstanceID = 0 AND
        tp_RowOrdinal = 0
    DECLARE @DelItemId int
    OPEN ListSeedData_cursor
    FETCH NEXT 
    FROM 
        ListSeedData_cursor
    INTO
        @DelItemId
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC proc_DropListRecord
            @SiteId,
            @WebId,
            @ListId,
            @ServerTemplate,
            @DelItemId,
            1,
            0,
            NULL,       
            NULL,       
            0,          
            0,          
            NULL        
        FETCH NEXT 
        FROM 
            ListSeedData_cursor
        INTO
            @DelItemId
    END
    CLOSE ListSeedData_cursor
    DEALLOCATE ListSeedData_cursor
    UPDATE
        UserData
    SET
        tp_InstanceID = NULL
    WHERE
        tp_ListId = @ListId
    RETURN 0        

GO
