/****** Object:  StoredProcedure [dbo].[DeleteRole]    Script Date: 5/15/2018 12:09:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Delete all policies associated with this role
CREATE PROCEDURE [dbo].[DeleteRole]
@RoleName nvarchar(260)
AS
SET NOCOUNT OFF
-- if you call this, you must delete/reconstruct all policies associated with this role
DELETE FROM Roles WHERE RoleName = @RoleName

GO
