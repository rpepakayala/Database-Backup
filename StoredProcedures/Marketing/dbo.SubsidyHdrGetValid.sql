/****** Object:  StoredProcedure [dbo].[SubsidyHdrGetValid]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.SubsidyHdrGetValid
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT SubsidyHdr.*, Material.MatAvailThru FROM MaterialSubsidy';
	SET @SQL = @SQL + ' JOIN SubsidyHdr ON MaterialSubsidy.SubHId = SubsidyHdr.SubHId';
	SET @SQL = @SQL + ' JOIN Material ON MaterialSubsidy.MatId = Material.MatId';
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
