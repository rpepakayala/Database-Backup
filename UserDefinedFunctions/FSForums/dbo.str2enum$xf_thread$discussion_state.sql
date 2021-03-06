/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_thread$discussion_state]    Script Date: 5/15/2018 12:14:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_thread$discussion_state 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'visible' THEN 1
            WHEN 'moderated' THEN 2
            WHEN 'deleted' THEN 3
            ELSE 0
         END
   END
GO
