/****** Object:  UserDefinedFunction [dbo].[str2enum$coupon_rules_items$table_type]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$coupon_rules_items$table_type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'attributes' THEN 1
            WHEN 'services' THEN 2
            WHEN 'products' THEN 3
            WHEN 'invoice' THEN 4
            ELSE 0
         END
   END
GO
