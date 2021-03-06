/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_route_prefix$build_link]    Script Date: 5/15/2018 12:14:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_route_prefix$build_link 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'all'
            WHEN 2 THEN 'data_only'
            WHEN 3 THEN 'none'
            ELSE ''
         END
   END
GO
