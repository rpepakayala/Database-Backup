/****** Object:  UserDefinedFunction [dbo].[norm_enum$xf_user_privacy$allow_send_personal_conversation]    Script Date: 5/15/2018 12:14:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.norm_enum$xf_user_privacy$allow_send_personal_conversation 
( 
   @setval nvarchar(max)
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN dbo.enum2str$xf_user_privacy$allow_send_personal_conversation(dbo.str2enum$xf_user_privacy$allow_send_personal_conversation(@setval))
   END
GO
