/****** Object:  StoredProcedure [dbo].[OrderMaterialViewGet]    Script Date: 5/15/2018 12:10:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE   PROCEDURE dbo.OrderMaterialViewGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT OrderDtl.*, Material.MatName, Material.MatOrderInc, Material.MatImprintable, IsNull(OrderDtlProofset.PrfSId,0) as PrfSId, OrderDtlProofset.OrdPSFoldingOption, OrderDtlProofset.OrdPSImprintQty, IsNull(ProofSet.PrfSName, ''Non-Imprintable'') as PrfSName, ';
	SET @SQL = @SQL + 'MaterialGroupsHdr.MatGHName, MaterialGroupsDtl.MatGDMailDate, OrderHdr.OrdHSignUpDeadline, OrderHdr.OrdHPrdType  ';
	SET @SQL = @SQL + 'FROM OrderDtl ';
	SET @SQL = @SQL + 'INNER JOIN Material ON ';
	SET @SQL = @SQL + 'OrderDtl.OrdDPrdId = Material.MatId ';
	SET @SQL = @SQL + 'INNER JOIN OrderHdr ON ';
	SET @SQL = @SQL + 'OrderDtl.OrdHId = OrderHdr.OrdHId ';
	SET @SQL = @SQL + 'Left Outer JOIN OrderDtlProofSet ON ';
	SET @SQL = @SQL + 'OrderDtl.OrdDPSId = OrderDtlProofSet.OrdPSId ';
	SET @SQL = @SQL + 'Left Outer JOIN ProofSet ON ';
	SET @SQL = @SQL + 'ProofSet.PrfSId = Material.MatProofSetId ';
	SET @SQL = @SQL + 'Left Outer Join MaterialGroupsHdr ON ';
	SET @SQL = @SQL + 'MaterialGroupsHdr.MatGHId = OrderDtl.OrdDPrdGId ';
	SET @SQL = @SQL + 'Left Outer Join MaterialGroupsDtl ';
	SET @SQL = @SQL + 'ON MaterialGroupsDtl.MatGHId = OrderDtl.OrdDPrdGId ';
	SET @SQL = @SQL + 'AND MaterialGroupsDtl.MatGPrdId = OrderDtl.OrdDPrdId ';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where ' + @Filter;
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
--PRINT(@SQL);
EXEC(@SQL);

GO
