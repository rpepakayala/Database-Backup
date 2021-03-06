/****** Object:  StoredProcedure [dbo].[ConstDescGroupViewGet]    Script Date: 5/15/2018 12:10:10 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.ConstDescGroupViewGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT ConstDescGroup.ConstGroupId, ConstDescGroup.Description AS GroupDescription, 
		ConstDesc.ConstId, ConstDesc.Description AS ConstDescription
		FROM  ConstDesc 
		INNER JOIN ConstDescGroup ON ConstDesc.ConstGroupId = ConstDescGroup.ConstGroupId ';
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
