/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_permission$permission_type]    Script Date: 5/15/2018 12:14:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_permission$permission_type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'flag'
            WHEN 2 THEN 'integer'
            ELSE ''
         END
   END
GO
