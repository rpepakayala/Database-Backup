/****** Object:  UserDefinedFunction [dbo].[fn_GetWelcomeName]    Script Date: 5/15/2018 12:15:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetWelcomeName(
@SiteId  uniqueidentifier,
@DirName nvarchar(256))
RETURNS TABLE
    RETURN SELECT TOP 1
        WelcomeName = WelcomeNames.LeafName
        FROM
            WelcomeNames INNER JOIN Docs
        ON
            WelcomeNames.LeafName = Docs.LeafName
        WHERE 
            SiteId = @SiteId AND
            Docs.DirName = @DirName
        ORDER BY Rank

GO
