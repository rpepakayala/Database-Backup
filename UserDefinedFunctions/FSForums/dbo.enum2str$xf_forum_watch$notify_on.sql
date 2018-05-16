/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_forum_watch$notify_on]    Script Date: 5/15/2018 12:14:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_forum_watch$notify_on 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN ''
            WHEN 2 THEN 'thread'
            WHEN 3 THEN 'message'
            ELSE ''
         END
   END
GO
