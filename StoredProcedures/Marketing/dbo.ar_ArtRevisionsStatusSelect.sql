/****** Object:  StoredProcedure [dbo].[ar_ArtRevisionsStatusSelect]    Script Date: 5/15/2018 12:10:08 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE ar_ArtRevisionsStatusSelect
AS
SET NOCOUNT ON
SELECT 
	ArtRevisionStatusID,
	Description,
	enum
FROM
	ar_ArtRevisionStatus
GO
