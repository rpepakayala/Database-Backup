/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_user_field$match_type]    Script Date: 5/15/2018 12:14:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_user_field$match_type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'none'
            WHEN 2 THEN 'number'
            WHEN 3 THEN 'alphanumeric'
            WHEN 4 THEN 'email'
            WHEN 5 THEN 'url'
            WHEN 6 THEN 'regex'
            WHEN 7 THEN 'callback'
            ELSE ''
         END
   END
GO
