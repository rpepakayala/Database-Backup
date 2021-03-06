/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_warning_definition$expiry_type]    Script Date: 5/15/2018 12:14:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_warning_definition$expiry_type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'never' THEN 1
            WHEN 'days' THEN 2
            WHEN 'weeks' THEN 3
            WHEN 'months' THEN 4
            WHEN 'years' THEN 5
            ELSE 0
         END
   END
GO
