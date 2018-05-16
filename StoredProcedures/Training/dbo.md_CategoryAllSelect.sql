/****** Object:  StoredProcedure [dbo].[md_CategoryAllSelect]    Script Date: 5/15/2018 12:13:20 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE md_CategoryAllSelect 
AS
SET NOCOUNT ON
SELECT
	 CategoryID, 
	Category, 
	ParentID 
FROM md_Categories
ORDER BY 
	ParentID,
             Category,
	CategoryID

GO
