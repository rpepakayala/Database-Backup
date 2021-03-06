/****** Object:  UserDefinedFunction [dbo].[fn_GetChildren]    Script Date: 5/15/2018 12:15:12 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetChildren
(
    @ParentId uniqueidentifier
)
RETURNS @Children TABLE (ChildId uniqueidentifier)
AS
    BEGIN
    INSERT INTO @Children (ChildId) VALUES (@ParentId)
    WHILE (@@ROWCOUNT <> 0)
    BEGIN
        INSERT
            @Children
        SELECT
            Id
        FROM
            Objects WITH (UPDLOCK)
        INNER JOIN
            @Children
        ON
            Objects.ParentId = ChildId
        WHERE 
            Id NOT IN (SELECT ChildId FROM @Children)
    END
    RETURN
    END

GO
