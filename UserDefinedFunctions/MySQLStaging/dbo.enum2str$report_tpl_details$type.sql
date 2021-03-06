/****** Object:  UserDefinedFunction [dbo].[enum2str$report_tpl_details$type]    Script Date: 5/15/2018 12:15:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$report_tpl_details$type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'text'
            WHEN 2 THEN 'repeat_text'
            WHEN 3 THEN 'end_repeat'
            WHEN 4 THEN 'image'
            WHEN 5 THEN 'line'
            WHEN 6 THEN 'rect'
            WHEN 7 THEN 'long_text'
            WHEN 8 THEN 'marker'
            WHEN 9 THEN 'na'
            WHEN 10 THEN 'page_break'
            WHEN 11 THEN 'pdf'
            WHEN 12 THEN 'header'
            WHEN 13 THEN 'rows'
            ELSE ''
         END
   END
GO
