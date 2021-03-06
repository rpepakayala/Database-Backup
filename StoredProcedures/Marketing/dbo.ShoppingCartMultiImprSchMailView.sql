/****** Object:  StoredProcedure [dbo].[ShoppingCartMultiImprSchMailView]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE  PROCEDURE dbo.ShoppingCartMultiImprSchMailView
(
	@MatIDs  varchar(1000) = null
)
AS
	DECLARE @SQL varchar(4000);
	
	SET NOCOUNT ON
	CREATE TABLE #tmpSMMIView(MatGHId int, MatGHType tinyint, MatGHName varchar(50), SignUpDate smalldatetime)
	SET @SQL = 
		'INSERT INTO #tmpSMMIView(MatGHId, MatGHType, MatGHName, SignUpDate)
			SELECT MatGHId, MatGHType, MatGHName, MatGHSignUpDate
			FROM MaterialGroupsHdr
				WHERE MatGHId IN  '  + @MatIDs ;
	EXEC(@SQL);
	UPDATE #tmpSMMIView
		SET SignUpDate = (SELECT TOP 1 MatGDSignUpDate FROM MaterialGroupsDtl mgd WHERE mgd.MatGHId = #tmpSMMIView.MatGHId AND MatGDSignUpDate > GETDATE() ORDER BY MatGDSignUpDate)
	WHERE MatGHType = 2
	SELECT * FROM #tmpSMMIView
	ORDER BY SignUpDate
	DROP TABLE #tmpSMMIView


GO
