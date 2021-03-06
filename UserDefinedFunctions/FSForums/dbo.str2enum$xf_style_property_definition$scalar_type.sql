/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_style_property_definition$scalar_type]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_style_property_definition$scalar_type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN '' THEN 1
            WHEN 'longstring' THEN 2
            WHEN 'color' THEN 3
            WHEN 'number' THEN 4
            WHEN 'boolean' THEN 5
            WHEN 'template' THEN 6
            ELSE 0
         END
   END
GO
