/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_forum_watch$notify_on]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_forum_watch$notify_on 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN '' THEN 1
            WHEN 'thread' THEN 2
            WHEN 'message' THEN 3
            ELSE 0
         END
   END
GO
