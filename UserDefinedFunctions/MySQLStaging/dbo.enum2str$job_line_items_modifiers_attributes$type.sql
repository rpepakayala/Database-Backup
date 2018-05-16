/****** Object:  UserDefinedFunction [dbo].[enum2str$job_line_items_modifiers_attributes$type]    Script Date: 5/15/2018 12:15:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$job_line_items_modifiers_attributes$type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'varchar'
            WHEN 2 THEN 'decimal'
            ELSE ''
         END
   END
GO
