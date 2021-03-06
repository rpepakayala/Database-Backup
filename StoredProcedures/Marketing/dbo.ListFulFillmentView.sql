/****** Object:  StoredProcedure [dbo].[ListFulFillmentView]    Script Date: 5/15/2018 12:10:14 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ListFulFillmentView
(
	@Filter  varchar(1000) = null,
	@OrderBy varchar(1000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL = 'SELECT oh.OrdHId, oh.OrdHDesc, oh.OrdHStoreId, oh.OrdHPrdType, oh.OrdHDate, oh.OrdHAmount, oh.OrdHStatus,
	op.OrdPmDate, op.OrdPmType, oh.OrdHFulfillmentDate, odmph.OrdDMPHListStatus, ot.Description AS OrderType
	FROM OrderHdr oh
	INNER JOIN OrderPayment op ON (op.OrdHId = oh.OrdHId)
	LEFT OUTER JOIN OrderDtlMailingProfileHdr odmph ON (odmph.OrdHId = oh.OrdHId)
	INNER JOIN ConstDesc ot ON (ot.ConstGroupId = 26 AND ot.ConstId = oh.OrdHPrdType)
	WHERE oh.OrdHStatus = 4 AND oh.OrdHSubStatus = 1 AND op.OrdPmCCStatus = 2 AND
	(odmph.OrdDMPHListStatus IS NULL OR odmph.OrdDMPHListStatus = 3)';
	
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' AND ' + @Filter;
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' ORDER BY  ' + @OrderBy;
	END
	;
	EXEC(@SQL);


GO
