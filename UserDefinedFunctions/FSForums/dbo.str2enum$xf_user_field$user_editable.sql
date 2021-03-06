/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_user_field$user_editable]    Script Date: 5/15/2018 12:14:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_user_field$user_editable 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'yes' THEN 1
            WHEN 'once' THEN 2
            WHEN 'never' THEN 3
            ELSE 0
         END
   END
GO
