/****** Object:  UserDefinedFunction [dbo].[str2enum$invoice_line_items$type]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$invoice_line_items$type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'service' THEN 1
            WHEN 'job' THEN 2
            WHEN 'modifier' THEN 3
            ELSE 0
         END
   END
GO
