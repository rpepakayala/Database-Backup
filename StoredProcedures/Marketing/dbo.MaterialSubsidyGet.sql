/****** Object:  StoredProcedure [dbo].[MaterialSubsidyGet]    Script Date: 5/15/2018 12:10:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.MaterialSubsidyGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT * FROM MaterialSubsidy';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where ' + @Filter;
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
EXEC(@SQL);


GO
