/****** Object:  UserDefinedFunction [dbo].[str2enum$coupon_rules$compound_type]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$coupon_rules$compound_type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'any' THEN 1
            WHEN 'except' THEN 2
            WHEN 'exactly' THEN 3
            ELSE 0
         END
   END
GO
