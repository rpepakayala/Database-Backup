/****** Object:  StoredProcedure [dbo].[SubsidyCategoryUpdate]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE SubsidyCategoryUpdate
(
	@SubHType int,
	@CategoryName varchar(50)
)
AS
UPDATE SubsidyCategories
SET
	CategoryName = @CategoryName
WHERE
	SubHType = @SubHType



GO
