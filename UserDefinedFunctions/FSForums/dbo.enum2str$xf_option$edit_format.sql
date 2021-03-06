/****** Object:  UserDefinedFunction [dbo].[enum2str$xf_option$edit_format]    Script Date: 5/15/2018 12:14:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.enum2str$xf_option$edit_format 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'textbox'
            WHEN 2 THEN 'spinbox'
            WHEN 3 THEN 'onoff'
            WHEN 4 THEN 'radio'
            WHEN 5 THEN 'select'
            WHEN 6 THEN 'checkbox'
            WHEN 7 THEN 'template'
            WHEN 8 THEN 'callback'
            WHEN 9 THEN 'onofftextbox'
            ELSE ''
         END
   END
GO
