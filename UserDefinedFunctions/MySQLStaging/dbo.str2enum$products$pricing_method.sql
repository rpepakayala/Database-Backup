/****** Object:  UserDefinedFunction [dbo].[str2enum$products$pricing_method]    Script Date: 5/15/2018 12:15:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$products$pricing_method 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'area' THEN 1
            WHEN 'linear' THEN 2
            WHEN 'fixed' THEN 3
            WHEN 'rigid' THEN 4
            WHEN 'manual' THEN 5
            WHEN 'table' THEN 6
            ELSE 0
         END
   END
GO
