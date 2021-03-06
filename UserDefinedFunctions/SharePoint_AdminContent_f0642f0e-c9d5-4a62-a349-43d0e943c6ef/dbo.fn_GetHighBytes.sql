/****** Object:  UserDefinedFunction [dbo].[fn_GetHighBytes]    Script Date: 5/15/2018 12:15:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetHighBytes(@in bigint)
RETURNS int
AS
BEGIN
    DECLARE @high bigint
    DECLARE @low  bigint
    SET @high = @in/0x100000000
    SET @low =  @in%0x100000000
    IF @in < 0 AND @low < 0
    BEGIN
        SET @high = @high - 1
    END
    RETURN CAST(@high as int)
END

GO
