/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_user_field$display_group]    Script Date: 5/15/2018 12:14:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_user_field$display_group 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'personal'
            WHEN 2 THEN 'contact'
            WHEN 3 THEN 'preferences'
            ELSE ''
         END
   END
GO
