/****** Object:  StoredProcedure [dbo].[proc_dropEmailEnabledListByAlias]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_dropEmailEnabledListByAlias
(
    @Alias nvarchar(128)
) AS
    SET NOCOUNT ON
    DELETE FROM
        dbo.EmailEnabledLists
    WHERE
        Alias = @Alias
    RETURN 0

GO
