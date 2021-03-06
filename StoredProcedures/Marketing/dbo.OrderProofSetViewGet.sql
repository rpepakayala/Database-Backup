/****** Object:  StoredProcedure [dbo].[OrderProofSetViewGet]    Script Date: 5/15/2018 12:10:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE  PROCEDURE dbo.OrderProofSetViewGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT Distinct OrderDtl.OrdHId, IsNull(OrderDtlProofSet.PrfSId,0) as PrfSId, IsNull(ProofSet.PrfSName,''Non-Imprintable'') as PrfSName, IsNull(ProofSet.PrfSFolding,''N'') as PrfSFolding, OrderDtl.OrdDPrdCatType';
	SET @SQL = @SQL + ' FROM  OrderDtl LEFT OUTER JOIN  OrderDtlProofSet ON OrderDtl.OrdDPSId = OrderDtlProofSet.OrdPSId LEFT OUTER JOIN ProofSet ON OrderDtlProofSet.PrfSId = ProofSet.PrfSId';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where ' + @Filter;
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
Print @SQL;
EXEC(@SQL);

GO
