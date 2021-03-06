/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_permission_entry$permission_value]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_permission_entry$permission_value 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'unset' THEN 1
            WHEN 'allow' THEN 2
            WHEN 'deny' THEN 3
            WHEN 'use_int' THEN 4
            ELSE 0
         END
   END
GO
