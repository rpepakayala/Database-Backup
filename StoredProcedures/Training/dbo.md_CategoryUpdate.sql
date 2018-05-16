/****** Object:  StoredProcedure [dbo].[md_CategoryUpdate]    Script Date: 5/15/2018 12:13:20 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE md_CategoryUpdate 
(
	@Category varchar(100),
	@CategoryID int,
 	@ParentID int
)
AS
SET NOCOUNT ON
UPDATE md_Categories
SET 
	Category = @Category,
	ParentID = @ParentID
WHERE CategoryID = @CategoryID

GO
