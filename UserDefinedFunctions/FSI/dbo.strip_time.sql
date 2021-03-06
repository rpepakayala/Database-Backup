/****** Object:  UserDefinedFunction [dbo].[strip_time]    Script Date: 5/15/2018 12:14:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
create function [dbo].[strip_time](
@indatetime datetime
)
returns datetime
as
BEGIN
DECLARE @outdatetime datetime, @yearpart char(4), @monthpart char(2), @daypart char(2)

SET @yearpart = RIGHT( '000' + CAST(YEAR(@indatetime) as varchar(4)) , 4 )
SET @monthpart = RIGHT( '0' + CAST(MONTH(@indatetime) as varchar(2)) , 2 )
SET @daypart = RIGHT( '0' + CAST(DAY(@indatetime) as varchar(2)) , 2 )

SET @outdatetime = @yearpart + @monthpart + @daypart

return @outdatetime
END

GO
