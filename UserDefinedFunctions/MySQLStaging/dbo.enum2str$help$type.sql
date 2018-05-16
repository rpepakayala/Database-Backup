/****** Object:  UserDefinedFunction [dbo].[enum2str$help$type]    Script Date: 5/15/2018 12:14:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$help$type 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'Action'
            WHEN 2 THEN 'Form'
            WHEN 3 THEN 'Input'
            ELSE ''
         END
   END
GO
