/****** Object:  UserDefinedFunction [dbo].[fn_getWebNumbersFromString]    Script Date: 5/15/2018 12:14:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE FUNCTION fn_getWebNumbersFromString  (@list nvarchar(MAX))
	RETURNS @tbl TABLE (Webnumber int NOT NULL) 
AS
BEGIN
   DECLARE @pos        int,
           @nextpos    int,
           @valuelen   int

   SELECT @pos = 0, @nextpos = 1

   WHILE @nextpos > 0
   BEGIN
      SELECT @nextpos = charindex(',', @list, @pos + 1)
      SELECT @valuelen = CASE WHEN @nextpos > 0
                              THEN @nextpos
                              ELSE len(@list) + 1
                         END - @pos - 1
      INSERT @tbl (Webnumber)
         VALUES (convert(int, substring(@list, @pos + 1, @valuelen)))
      SELECT @pos = @nextpos
   END
  RETURN

END

GO
