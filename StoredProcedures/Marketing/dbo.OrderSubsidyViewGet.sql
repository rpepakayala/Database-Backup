/****** Object:  StoredProcedure [dbo].[OrderSubsidyViewGet]    Script Date: 5/15/2018 12:10:22 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.OrderSubsidyViewGet
(
	@StoreId int = null,
	@SubYear int = null,
	@OrdHId int = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT OrderDtl.OrdHId, OrderDtl.OrdDId, OrderDtl.OrdDPrdId, Material.MatName, OrderDtl.OrdDQty, OrderDtl.OrdDPrice, MaterialSubsidy.SubHId, ' +
		             'isnull(test.SubHType, 0) as SubHType, isnull(test.SubHDesc, '') as SubHDesc, isnull(test.StoreSId, 0) as StoreSId, isnull(test.StoreSubYear, 0) as StoreSubYear '+
		             'FROM OrderDtl left outer join Material ON Material.MatId = OrderDtl.OrdDPrdId LEFT OUTER JOIN ' +
		             'MaterialSubsidy ON MaterialSubsidy.MatId = OrderDtl.OrdDPrdId left outer join ' +
		             ' (SELECT SubsidyHdr.SubHId, SubsidyHdr.SubHType, SubsidyHdr.SubHDesc, StoreSubsidy.StoreSId, StoreSubsidy.StoreSubYear ' +
		             ' FROM	SubsidyHdr left outer join StoreSubsidy ON StoreSubsidy.StoreSubHId = SubsidyHdr.SubHId ' +
		             ' WHERE  (StoreSubsidy.StoreSId = ' + @StoreId + ') AND (StoreSubsidy.StoreSubYear = ' + @SubYear + ') ' +
		             ') test on test.SubHId = MaterialSubsidy.SubHId ' +
		             'WHERE  (OrderDtl.OrdHId = ' + @OrdHId + ') '
;
EXEC(@SQL);


GO
