/****** Object:  StoredProcedure [dbo].[proc_MakeViewMobileDefaultForList]    Script Date: 5/15/2018 12:12:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MakeViewMobileDefaultForList(
    @ListId uniqueidentifier,
    @ViewId uniqueidentifier)
AS
    SET NOCOUNT ON
    UPDATE
        WebParts
    SET
        tp_Flags = CASE WHEN tp_ID = @ViewId 
            THEN tp_Flags | 16777216 
            ELSE tp_Flags & ~ (0 | 16777216) END
    WHERE
        tp_ListId = @ListId AND
        tp_UserID IS NULL AND
        (tp_Type = 0 OR tp_Type = 1)
    RETURN 0

GO
