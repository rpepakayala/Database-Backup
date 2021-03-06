/****** Object:  UserDefinedFunction [dbo].[SSIS_ReturnFSI_ID]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Tim Fleck
-- Create date: 2/4/2014
-- Description:	Function to Strip Keystone ID's from our Cryius ID's
-- =============================================
CREATE FUNCTION SSIS_ReturnFSI_ID
(
	
	@ZW_Franchise_ID CHAR(7),@KeystoneID varchar(32)
)
RETURNS INT
AS
BEGIN
	DECLARE @ID INT
	SELECT @ID = CASE WHEN LEN(@KeystoneID)=32 THEN 0 
	WHEN @KeystoneID LIKE @ZW_Franchise_ID+':A%' THEN CAST(REPLACE(@KeystoneID,@ZW_Franchise_ID+':A','') AS INT)
	ELSE 0 
	END
	RETURN @ID
END

GO
