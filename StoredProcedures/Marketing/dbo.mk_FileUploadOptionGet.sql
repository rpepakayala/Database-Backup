/****** Object:  StoredProcedure [dbo].[mk_FileUploadOptionGet]    Script Date: 5/15/2018 12:10:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON




CREATE PROCEDURE mk_FileUploadOptionGet 
(
	@OptionID int
)
AS
SELECT *
FROM FileUploadOptions
WHERE OptionID = @OptionID



GO
