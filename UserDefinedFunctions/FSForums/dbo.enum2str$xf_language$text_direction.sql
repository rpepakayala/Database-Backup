/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_language$text_direction]    Script Date: 5/15/2018 12:14:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_language$text_direction 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'LTR'
            WHEN 2 THEN 'RTL'
            ELSE ''
         END
   END
GO
