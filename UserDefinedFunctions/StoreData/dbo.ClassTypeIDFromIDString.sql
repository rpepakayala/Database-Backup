/****** Object:  UserDefinedFunction [dbo].[ClassTypeIDFromIDString]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION ClassTypeIDFromIDString (@IDStr varchar(15))
RETURNS int
AS
BEGIN
  -- Declare the return variable here
  DECLARE @ID int;
  DECLARE @CommaPos int;

  -- Find the location of the comma
  SET @CommaPos = CHARINDEX ( ',', @IDStr, 2 ); 	
  SELECT @ID = Cast(Substring(@IDStr, @CommaPos+1, Len(@IDStr)-@CommaPos-1) as Int);

  -- Return the result of the function
  RETURN @ID
END

GO
