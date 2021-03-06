/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_user_field$user_editable]    Script Date: 5/15/2018 12:14:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_user_field$user_editable 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'yes'
            WHEN 2 THEN 'once'
            WHEN 3 THEN 'never'
            ELSE ''
         END
   END
GO
