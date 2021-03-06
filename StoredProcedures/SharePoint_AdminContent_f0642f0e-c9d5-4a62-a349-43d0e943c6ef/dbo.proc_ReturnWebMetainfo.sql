/****** Object:  StoredProcedure [dbo].[proc_ReturnWebMetainfo]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ReturnWebMetainfo(
    @WebId uniqueidentifier)
AS    
    SET NOCOUNT ON
    SELECT
        Category
    FROM
        WebCat
    WHERE
        WebId = @WebId
    SELECT
        Webs.MetaInfo
    FROM
        Webs
    WHERE
        Id = @WebId
    IF @@ROWCOUNT <> 1 
    BEGIN
        RETURN 3
    END
    RETURN 0

GO
