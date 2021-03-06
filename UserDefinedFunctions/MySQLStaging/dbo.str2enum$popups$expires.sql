/****** Object:  UserDefinedFunction [dbo].[str2enum$popups$expires]    Script Date: 5/15/2018 12:15:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$popups$expires 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'Never' THEN 1
            WHEN 'Date' THEN 2
            WHEN 'On Close' THEN 3
            ELSE 0
         END
   END
GO
