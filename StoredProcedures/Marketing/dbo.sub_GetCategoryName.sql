/****** Object:  StoredProcedure [dbo].[sub_GetCategoryName]    Script Date: 5/15/2018 12:10:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_GetCategoryName
(
	@SubHType int
)
AS
SELECT CategoryName
FROM SubsidyCategories
WHERE
	SubHType = @SubHType



GO
