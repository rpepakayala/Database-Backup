/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_user_field$match_type]    Script Date: 5/15/2018 12:14:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_user_field$match_type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'none' THEN 1
            WHEN 'number' THEN 2
            WHEN 'alphanumeric' THEN 3
            WHEN 'email' THEN 4
            WHEN 'url' THEN 5
            WHEN 'regex' THEN 6
            WHEN 'callback' THEN 7
            ELSE 0
         END
   END
GO
