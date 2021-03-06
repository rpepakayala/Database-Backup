/****** Object:  StoredProcedure [dbo].[ESSO_GetAllLoginCredentials]    Script Date: 5/15/2018 12:09:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


-- =============================================
-- Author:		<Shreyas Patel>
-- Create date: <11/26/2012>
-- Description:	<This store procedure is used to retrieve all External Site Login credentials. This procedure is required to perform ESSO>
-- =============================================
CREATE PROCEDURE [dbo].[ESSO_GetAllLoginCredentials] (@FIIUserID int)
AS
BEGIN
	BEGIN TRY
	   SET NOCOUNT ON;

			-- make sure that @FIIUserID input parameter is not NULL or empty
			 IF ISNULL(@FIIUserID, 0) = 0
				BEGIN
					RETURN (90)
				END
			-- make sure that provided @FIIUserID exists in FIISecurity.FIIUser table	
			IF NOT EXISTS(SELECT * FROM FIIUser WHERE Active = 1 AND Deleted = 0 AND UserID = @FIIUserID)
				BEGIN
					RETURN (91)
				END
			
			-- Perfrom Joins	
			-- ============================
			-- we want all records from FII_ESSO_ExternalApplications table eventhough if there are no related records 
			-- in FII_ESSO_ExternalApplicationUsers table for the specified FIIUserID
			
			SELECT EA.ExternalAppID, EA.ExternalAppName, EA.ExternalAppLoginURI, EA.ExternalAppDescription, EA.ExternalAppImageFile,
			EA.ControllerPage, EA.ExternalAppWebsiteURI, EAUsers.ExternalAppUserID, EAUsers.ExternalAppLoginID,
			EAUsers.ExternalAppPassword, EAusers.PasswordEncryptionKey 
			FROM FII_ESSO_ExternalApplications EA 
			LEFT JOIN FII_ESSO_ExternalApplicationUsers EAusers ON 
			(EA.ExternalAppID = EAusers.ExternalAppId AND EAusers.FIIUserID = @FIIUserID AND EAusers.Active = 1)
			WHERE 
			EA.Active = 1 
		END TRY
		
		BEGIN CATCH
			RETURN (92)
		END CATCH
END



GO
