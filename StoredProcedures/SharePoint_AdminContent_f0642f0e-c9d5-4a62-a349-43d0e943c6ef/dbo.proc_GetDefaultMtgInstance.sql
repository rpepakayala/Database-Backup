/****** Object:  StoredProcedure [dbo].[proc_GetDefaultMtgInstance]    Script Date: 5/15/2018 12:12:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetDefaultMtgInstance
(
    @WebId  uniqueidentifier
)
AS
    SET NOCOUNT ON
    DECLARE @MeetingsListID uniqueidentifier
    EXEC proc_GetUniqueList @WebId, 200, @MeetingsListID OUTPUT
    IF @MeetingsListID IS NULL
        RETURN 13
    SELECT
        bit3, tp_InstanceID, int1, uniqueidentifier1, datetime3, datetime1, datetime2, int2, ntext1, ntext2, ntext3, datetime5, int3
    FROM
        UserData
    WHERE
        tp_ListId = @MeetingsListID AND
        tp_RowOrdinal = 0
    RETURN 0        

GO
