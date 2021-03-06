/****** Object:  UserDefinedFunction [dbo].[fn_SizeOfSmartPage]    Script Date: 5/15/2018 12:15:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_SizeOfSmartPage(
    @SiteID uniqueidentifier,
    @DocID uniqueidentifier,
    @Level tinyint)
RETURNS bigint
    BEGIN
        DECLARE @cbDelta bigint
        SELECT
            @cbDelta = ISNULL((SUM(CAST((tp_Size) AS BIGINT))), 0)
        FROM
            WebParts
        WHERE
            WebParts.tp_SiteID = @SiteId AND
            WebParts.tp_PageUrlID = @DocID AND
            WebParts.tp_Level = @Level
        IF @cbDelta > 0
        BEGIN
            SELECT
                @cbDelta = @cbDelta + ISNULL((SUM(CAST((tp_Size) AS BIGINT))), 0)
            FROM
                Personalization
            WHERE
                Personalization.tp_SiteID = @SiteId AND
                Personalization.tp_PageUrlID = @DocID
        END
        RETURN @cbDelta
    END

GO
