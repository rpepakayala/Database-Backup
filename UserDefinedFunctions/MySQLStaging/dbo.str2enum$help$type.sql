/****** Object:  UserDefinedFunction [dbo].[str2enum$help$type]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$help$type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'Action' THEN 1
            WHEN 'Form' THEN 2
            WHEN 'Input' THEN 3
            ELSE 0
         END
   END
GO
