/****** Object:  StoredProcedure [dbo].[md_CategoryInsert]    Script Date: 5/15/2018 12:13:20 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE md_CategoryInsert 
(
	@Category varchar(100),
	@ParentID int
)
AS
SET NOCOUNT ON
INSERT INTO md_Categories
(
	Category,
	ParentID
)
VALUES
(
	@Category,
	@ParentID
)
RETURN @@IDENTITY

GO
