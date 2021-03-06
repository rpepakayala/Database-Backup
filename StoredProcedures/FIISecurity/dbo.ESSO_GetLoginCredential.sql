/****** Object:  StoredProcedure [dbo].[ESSO_GetLoginCredential]    Script Date: 5/15/2018 12:09:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



-- =============================================
-- Author:		<Shreyas Patel>
-- Create date: <11/26/2012>
-- Description:	<This store procedure is used to retrieve all External Site Login credentials. This procedure is required to perform ESSO>
-- =============================================
CREATE PROCEDURE [dbo].[ESSO_GetLoginCredential] (@ExternalAppID int, @FIIUserId int)
AS
BEGIN
	BEGIN TRY
	   SET NOCOUNT ON;

			-- make sure that @UserID input parameter is not NULL or empty
			 IF ISNULL(@ExternalAppID, 0) = 0
				BEGIN
					RETURN (90)
				END
			
			
			-- Perfrom Joins	
			SELECT EA.ExternalAppID, EA.ExternalAppName, EA.ExternalAppLoginURI, EA.ExternalAppDescription, EA.ExternalAppImageFile,
			EA.ControllerPage, EA.ExternalAppWebsiteURI, EAUsers.ExternalAppUserID, EAUsers.ExternalAppLoginID,
			EAUsers.ExternalAppPassword, EAusers.PasswordEncryptionKey 
			FROM FII_ESSO_ExternalApplications EA 
			INNER JOIN FII_ESSO_ExternalApplicationUsers EAusers ON 
			(EA.ExternalAppID = EAusers.ExternalAppId AND EAusers.FIIUserId = @FIIUserId 
			And EAusers.ExternalAppID = @ExternalAppID AND EAusers.Active = 1)
			WHERE 
			EA.Active = 1 
		END TRY
		
		BEGIN CATCH
			RETURN (92)
		END CATCH
END




GO
