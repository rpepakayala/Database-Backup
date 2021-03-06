/****** Object:  UserDefinedFunction [dbo].[str2enum$invoices$roll_up_method]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$invoices$roll_up_method 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'detailed' THEN 1
            WHEN 'price' THEN 2
            WHEN 'all' THEN 3
            WHEN 'default' THEN 4
            ELSE 0
         END
   END
GO
