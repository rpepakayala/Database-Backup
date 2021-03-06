/****** Object:  UserDefinedFunction [dbo].[str2enum$xf_report$report_state]    Script Date: 5/15/2018 12:14:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$xf_report$report_state 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'open' THEN 1
            WHEN 'assigned' THEN 2
            WHEN 'resolved' THEN 3
            WHEN 'rejected' THEN 4
            ELSE 0
         END
   END
GO
