/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_user_option$default_watch_state]    Script Date: 5/15/2018 12:14:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_user_option$default_watch_state 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN ''
            WHEN 2 THEN 'watch_no_email'
            WHEN 3 THEN 'watch_email'
            ELSE ''
         END
   END
GO
