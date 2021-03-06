/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_conversation_recipient$recipient_state]    Script Date: 5/15/2018 12:14:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_conversation_recipient$recipient_state 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'active'
            WHEN 2 THEN 'deleted'
            WHEN 3 THEN 'deleted_ignored'
            ELSE ''
         END
   END
GO
