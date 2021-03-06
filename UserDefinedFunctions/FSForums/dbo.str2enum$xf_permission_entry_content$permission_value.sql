/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_permission_entry_content$permission_value]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_permission_entry_content$permission_value 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'unset' THEN 1
            WHEN 'reset' THEN 2
            WHEN 'content_allow' THEN 3
            WHEN 'deny' THEN 4
            WHEN 'use_int' THEN 5
            ELSE 0
         END
   END
GO
