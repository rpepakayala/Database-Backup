/****** Object:  UserDefinedFunction [dbo].[str2enum$jobs_assets$asset_type]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.str2enum$jobs_assets$asset_type 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'image' THEN 1
            WHEN 'file' THEN 2
            ELSE 0
         END
   END
GO
