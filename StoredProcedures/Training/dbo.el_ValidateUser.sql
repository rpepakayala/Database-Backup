/****** Object:  StoredProcedure [dbo].[el_ValidateUser]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE el_ValidateUser
(   
	@UserName varchar(6),
	@Password varchar(50),
	@StoreNumber int
)

AS

SELECT WebID, UserID, UserName
FROM AWUsers
WHERE 
	UserName = @UserName
	AND Password = @Password
	AND WebID = @StoreNumber
GO
