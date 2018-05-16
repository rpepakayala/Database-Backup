/****** Object:  StoredProcedure [dbo].[md_VideoCategoriesSelect]    Script Date: 5/15/2018 12:13:20 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE md_VideoCategoriesSelect
(
	@VideoID int
)
AS
SET NOCOUNT ON
SELECT  
	categoryID
FROM
	md_videosInCategories
WHERE
	VideoID = @VideoID
ORDER BY
	categoryID

GO
