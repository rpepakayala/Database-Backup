/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_session_activity$view_state]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_session_activity$view_state 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'valid' THEN 1
            WHEN 'error' THEN 2
            ELSE 0
         END
   END
GO
