/****** Object:  UserDefinedFunction [dbo].[fn_NavCacheMask]    Script Date: 5/15/2018 12:15:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_NavCacheMask(@eid int)
RETURNS int
AS
BEGIN
    DECLARE @ret int
    SET
        @ret =
    CASE @eid
        WHEN 1001 THEN 2
        WHEN 1002 THEN 4
        WHEN 1003 THEN 8
        WHEN 1004 THEN 16
        WHEN 1005 THEN 32
        WHEN 1006 THEN 64
        WHEN 1007 THEN 128
        WHEN 1008 THEN 256
        ELSE 0 END
    RETURN @ret
END

GO
