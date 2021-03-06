/****** Object:  UserDefinedFunction [dbo].[SQLAGENT_SUSER_SID]    Script Date: 5/15/2018 12:14:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE FUNCTION dbo.SQLAGENT_SUSER_SID(@user_name sysname) RETURNS VARBINARY(85)
AS
BEGIN
  DECLARE @ret VARBINARY(85)
  IF @user_name = N'$(SQLAgentAccount)'
    SELECT @ret = 0xFFFFFFFF
  ELSE
    SELECT @ret = SUSER_SID(@user_name, 0)
  RETURN @ret
END

GO
