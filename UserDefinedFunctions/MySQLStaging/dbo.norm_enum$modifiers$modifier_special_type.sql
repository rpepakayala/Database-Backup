/****** Object:  UserDefinedFunction [dbo].[norm_enum$modifiers$modifier_special_type]    Script Date: 5/15/2018 12:15:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.norm_enum$modifiers$modifier_special_type 
( 
   @setval nvarchar(max)
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN dbo.enum2str$modifiers$modifier_special_type(dbo.str2enum$modifiers$modifier_special_type(@setval))
   END
GO
