/****** Object:  UserDefinedFunction [dbo].[XMLToText]    Script Date: 5/15/2018 12:15:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION XMLToText (
	-- Add the parameters for the function here
	@InputText varchar(4096)
)
RETURNS varchar(4096)
AS
BEGIN 
	-- Since often no transformation is needed, do a quick scan first
	IF (@InputText is Null) OR (PatIndex('%&%;%', @InputText) = 0) 
      RETURN @InputText;

	-- Declare the return variable here
	DECLARE @Result varchar(4096);

	-- Now replace all instances of ASCII characters not allowed in XML
	Set @Result = Replace(@InputText, '&amp;', '&');  -- must do this one first
	Set @Result = Replace(@Result, '&gt;', '>');  
	Set @Result = Replace(@Result, '&lt;', '<');  
	Set @Result = Replace(@Result, '&apos;', '''');  
	Set @Result = Replace(@Result, '&quot;', '"');  

	-- Return the result of the function
	RETURN @Result
END

GO
