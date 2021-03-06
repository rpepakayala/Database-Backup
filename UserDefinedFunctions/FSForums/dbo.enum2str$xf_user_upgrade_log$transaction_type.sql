/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_user_upgrade_log$transaction_type]    Script Date: 5/15/2018 12:14:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_user_upgrade_log$transaction_type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'payment'
            WHEN 2 THEN 'cancel'
            WHEN 3 THEN 'info'
            WHEN 4 THEN 'error'
            ELSE ''
         END
   END
GO
