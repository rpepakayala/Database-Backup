/****** Object:  UserDefinedFunction [dbo].[fn_GetMobileDefaultViewUrl]    Script Date: 5/15/2018 12:15:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetMobileDefaultViewUrl(@ListID uniqueidentifier)
RETURNS nvarchar(260)
AS
BEGIN
    DECLARE @strUrl nvarchar(256)
    SELECT
        @strUrl = N'/' + CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM
        WebParts,
        Docs
    WHERE
        WebParts.tp_ListId = @ListID AND
        WebParts.tp_UserID IS NULL AND
	    (WebParts.tp_Flags & 16777216) <> 0 AND
	    WebParts.tp_Level = 1 AND
    	Docs.Id = WebParts.tp_PageUrlID AND
	    Docs.Level = WebParts.tp_Level
    return @strUrl
END

GO
