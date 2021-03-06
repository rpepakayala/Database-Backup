/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_ip_match$match_type]    Script Date: 5/15/2018 12:14:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_ip_match$match_type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'banned'
            WHEN 2 THEN 'discouraged'
            ELSE ''
         END
   END
GO
