/****** Object:  UserDefinedFunction [dbo].[fn_ChangeEndian4]    Script Date: 5/15/2018 12:15:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_ChangeEndian4(@in int)
RETURNS binary(4)
AS
BEGIN
    DECLARE @high int
    DECLARE @low int
    SET @high = @in/0x10000
    SET @low =  @in%0x10000
    IF @in < 0 AND @low < 0
    BEGIN
        SET @high = @high - 1
        SET @low = @low + 0x10000
    END
    IF @low >= 0x8000
        SET @low = @low - 0x10000 
    RETURN dbo.fn_ChangeEndian2(@low) + dbo.fn_ChangeEndian2(@high)
END

GO
