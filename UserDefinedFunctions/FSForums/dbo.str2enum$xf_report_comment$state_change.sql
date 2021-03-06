/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_report_comment$state_change]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_report_comment$state_change 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN '' THEN 1
            WHEN 'open' THEN 2
            WHEN 'assigned' THEN 3
            WHEN 'resolved' THEN 4
            WHEN 'rejected' THEN 5
            ELSE 0
         END
   END
GO
