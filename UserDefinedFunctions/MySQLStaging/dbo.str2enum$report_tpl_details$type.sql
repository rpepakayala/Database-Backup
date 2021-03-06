/****** Object:  UserDefinedFunction [dbo].[str2enum$report_tpl_details$type]    Script Date: 5/15/2018 12:15:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$report_tpl_details$type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'text' THEN 1
            WHEN 'repeat_text' THEN 2
            WHEN 'end_repeat' THEN 3
            WHEN 'image' THEN 4
            WHEN 'line' THEN 5
            WHEN 'rect' THEN 6
            WHEN 'long_text' THEN 7
            WHEN 'marker' THEN 8
            WHEN 'na' THEN 9
            WHEN 'page_break' THEN 10
            WHEN 'pdf' THEN 11
            WHEN 'header' THEN 12
            WHEN 'rows' THEN 13
            ELSE 0
         END
   END
GO
