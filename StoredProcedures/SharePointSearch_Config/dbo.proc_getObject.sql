/****** Object:  StoredProcedure [dbo].[proc_getObject]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getObject
(
    @Id uniqueidentifier
) AS
    SET NOCOUNT ON
    SELECT
        Id,
        ParentId,
        ClassId,
        Name,
        Status,
        Version,
        Properties
    FROM
        Objects
    WHERE
        Id = @Id
    RETURN 0 

GO
