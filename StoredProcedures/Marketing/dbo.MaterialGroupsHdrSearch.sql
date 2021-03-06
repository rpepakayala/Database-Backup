/****** Object:  StoredProcedure [dbo].[MaterialGroupsHdrSearch]    Script Date: 5/15/2018 12:10:16 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.MaterialGroupsHdrSearch
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT MaterialGroupsHdr.MatGHId, MaterialGroupsHdr.MatGHName from MaterialGroupsHdr';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where MaterialGroupsHdr.MatGHId In (SELECT Distinct(MaterialGroupsHdr.MatGHId) FROM MaterialGroupsHdr Inner Join MaterialGroupsDtl on MaterialGroupsHdr.MatGHId=MaterialGroupsDtl.MatGHId Where ' + @Filter + ')';
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
EXEC(@SQL);


GO
