/****** Object:  UserDefinedFunction [dbo].[norm_enum$job_line_items_modifiers_attributes$type]    Script Date: 5/15/2018 12:15:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.norm_enum$job_line_items_modifiers_attributes$type 
( 
   @setval nvarchar(max)
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN dbo.enum2str$job_line_items_modifiers_attributes$type(dbo.str2enum$job_line_items_modifiers_attributes$type(@setval))
   END
GO
