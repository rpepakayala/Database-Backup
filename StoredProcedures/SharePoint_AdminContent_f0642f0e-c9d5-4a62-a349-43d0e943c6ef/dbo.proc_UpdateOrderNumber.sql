/****** Object:  StoredProcedure [dbo].[proc_UpdateOrderNumber]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateOrderNumber(
    @SiteId                      uniqueidentifier,
    @WebId                       uniqueidentifier,
    @ListId                      uniqueidentifier,
    @BaseType                    int,
    @ItemId                      int,
    @ItemOrder                   int,
    @fMultipleMtgDataList        bit,
    @RootFolderUrl               nvarchar(256),
    @fUpdateDTM                  bit = 0,
    @InstanceId                  int = -3 )
AS
    SET NOCOUNT ON
    DECLARE @CorrectOrder float
    DECLARE @Ret int
    EXEC @Ret = proc_GetTargetOrderNumber 
        @SiteId, 
        @WebId, 
        @ListId, 
        @BaseType, 
        @ItemId, 
        @ItemOrder, 
        @CorrectOrder OUTPUT,
        1,  
        @RootFolderUrl, 
        @fMultipleMtgDataList, 
        @InstanceId 
    IF (@Ret <> 0)
        RETURN @Ret
    UPDATE
        UserData
    SET
        tp_ItemOrder = @CorrectOrder
    WHERE
        tp_ListId = @ListId AND
        tp_ID = @ItemId
    IF (@fUpdateDTM = 1)
    BEGIN
        UPDATE
            Lists
        SET
            tp_Modified = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        WHERE
            tp_WebId = @WebId AND
            tp_ID = @ListId
    END
    RETURN 0

GO
