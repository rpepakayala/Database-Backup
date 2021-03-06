/****** Object:  UserDefinedFunction [dbo].[enum2str$popups$expires]    Script Date: 5/15/2018 12:15:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$popups$expires 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'Never'
            WHEN 2 THEN 'Date'
            WHEN 3 THEN 'On Close'
            ELSE ''
         END
   END
GO
