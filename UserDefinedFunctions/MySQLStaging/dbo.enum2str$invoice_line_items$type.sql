/****** Object:  UserDefinedFunction [dbo].[enum2str$invoice_line_items$type]    Script Date: 5/15/2018 12:15:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$invoice_line_items$type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'service'
            WHEN 2 THEN 'job'
            WHEN 3 THEN 'modifier'
            ELSE ''
         END
   END
GO
