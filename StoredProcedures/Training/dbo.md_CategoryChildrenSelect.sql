/****** Object:  StoredProcedure [dbo].[md_CategoryChildrenSelect]    Script Date: 5/15/2018 12:13:20 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE  PROCEDURE md_CategoryChildrenSelect 
(
	@CategoryID int
)
AS
SET NOCOUNT ON 
SELECT CategoryID, Category, IsParent = dbo.fn_IsCategoryParent(CategoryID), IsAttached = dbo.fn_IsCategoryAttached(CategoryID)
FROM md_Categories
WHERE ParentID = @CategoryID
ORDER BY Category

GO
