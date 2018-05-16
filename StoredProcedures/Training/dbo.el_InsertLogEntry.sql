/****** Object:  StoredProcedure [dbo].[el_InsertLogEntry]    Script Date: 5/15/2018 12:13:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE el_InsertLogEntry
(   
	@UserID int 
)

AS

INSERT INTO awLogEntries
(
	UserID, 
	DateAccessed
)
VALUES
(
	@UserID, 
	getDate() 
)
GO
