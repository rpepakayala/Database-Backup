/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_route_prefix$build_link]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_route_prefix$build_link 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'all' THEN 1
            WHEN 'data_only' THEN 2
            WHEN 'none' THEN 3
            ELSE 0
         END
   END
GO
