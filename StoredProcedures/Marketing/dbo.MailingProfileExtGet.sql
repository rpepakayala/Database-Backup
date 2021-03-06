/****** Object:  StoredProcedure [dbo].[MailingProfileExtGet]    Script Date: 5/15/2018 12:10:14 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.MailingProfileExtGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT MailingProfile.*, SICTemplate.Name FROM MailingProfile';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where ' + @Filter;
	END
	SET @SQL = @SQL + ' JOIN SICTemplate ON MailingProfile.SicHId = SICTemplate.Id';
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
EXEC(@SQL);


GO
