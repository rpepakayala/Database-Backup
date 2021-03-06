/****** Object:  StoredProcedure [dbo].[ShoppingCartUpdate]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ShoppingCartUpdate
(
	@ScStoreId int = NULL,
	@ScStoreIdFlag bit = NULL,
	@ScId int = NULL,
	@ScType tinyint = NULL,
	@ScTypeFlag bit = NULL,
	@ScCatlId int = NULL,
	@ScCatlIdFlag bit = NULL,
	@ScCatId int = NULL,
	@ScCatIdFlag bit = NULL,
	@ScOrderPrdType tinyint = NULL,
	@ScOrderPrdTypeFlag bit = NULL,
	@ScCatType tinyint = NULL,
	@ScCatTypeFlag bit = NULL,
	@ScPrdGId int = NULL,
	@ScPrdGIdFlag bit = NULL,
	@ScRMPHId int = NULL,
	@ScRMPHIdFlag bit = NULL,
	@ScPrdId int = NULL,
	@ScPrdIdFlag bit = NULL,
	@ScQty int = NULL,
	@ScQtyFlag bit = NULL,
	@ScMailDate smalldatetime = NULL,
	@ScMailDateFlag bit = NULL,
	@ScImprint char(1) = NULL,
	@ScImprintFlag bit = NULL,
	@ScAdded smalldatetime = NULL,
	@ScAddedFlag bit = NULL,
	@ScMailOnDemandPostageType tinyint = NULL,
	@ScMailOnDemandPostageTypeFlag bit = NULL,
	@ScMailOnDemandPostageFee float = NULL,
	@ScMailOnDemandPostageFeeFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@ScStoreIdFlag Is Not NULL)
BEGIN
	IF (@ScStoreId Is Not NULL)
		SET @SQL = @SQL + 'ScStoreId=' + convert(varchar,@ScStoreId) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScStoreId=NULL, ';
END
IF (@ScTypeFlag Is Not NULL)
BEGIN
	IF (@ScType Is Not NULL)
		SET @SQL = @SQL + 'ScType=' + convert(varchar,@ScType) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScType=NULL, ';
END
IF (@ScCatlIdFlag Is Not NULL)
BEGIN
	IF (@ScCatlId Is Not NULL)
		SET @SQL = @SQL + 'ScCatlId=' + convert(varchar,@ScCatlId) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScCatlId=NULL, ';
END
IF (@ScCatIdFlag Is Not NULL)
BEGIN
	IF (@ScCatId Is Not NULL)
		SET @SQL = @SQL + 'ScCatId=' + convert(varchar,@ScCatId) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScCatId=NULL, ';
END
IF (@ScOrderPrdTypeFlag Is Not NULL)
BEGIN
	IF (@ScOrderPrdType Is Not NULL)
		SET @SQL = @SQL + 'ScOrderPrdType=' + convert(varchar,@ScOrderPrdType) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScOrderPrdType=NULL, ';
END
IF (@ScCatTypeFlag Is Not NULL)
BEGIN
	IF (@ScCatType Is Not NULL)
		SET @SQL = @SQL + 'ScCatType=' + convert(varchar,@ScCatType) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScCatType=NULL, ';
END
IF (@ScPrdGIdFlag Is Not NULL)
BEGIN
	IF (@ScPrdGId Is Not NULL)
		SET @SQL = @SQL + 'ScPrdGId=' + convert(varchar,@ScPrdGId) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScPrdGId=NULL, ';
END
IF (@ScRMPHIdFlag Is Not NULL)
BEGIN
	IF (@ScRMPHId Is Not NULL)
		SET @SQL = @SQL + 'ScRMPHId=' + convert(varchar,@ScRMPHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScRMPHId=NULL, ';
END
IF (@ScPrdIdFlag Is Not NULL)
BEGIN
	IF (@ScPrdId Is Not NULL)
		SET @SQL = @SQL + 'ScPrdId=' + convert(varchar,@ScPrdId) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScPrdId=NULL, ';
END
IF (@ScQtyFlag Is Not NULL)
BEGIN
	IF (@ScQty Is Not NULL)
		SET @SQL = @SQL + 'ScQty=' + convert(varchar,@ScQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScQty=NULL, ';
END
IF (@ScMailDateFlag Is Not NULL)
BEGIN
	IF (@ScMailDate Is Not NULL)
		SET @SQL = @SQL + 'ScMailDate=''' + convert(varchar,@ScMailDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'ScMailDate=NULL, ';
END
IF (@ScImprintFlag Is Not NULL)
BEGIN
	IF (@ScImprint Is Not NULL)
		SET @SQL = @SQL + 'ScImprint=''' + @ScImprint + ''', ';
	ELSE
		SET @SQL = @SQL + 'ScImprint=NULL, ';
END
IF (@ScAddedFlag Is Not NULL)
BEGIN
	IF (@ScAdded Is Not NULL)
		SET @SQL = @SQL + 'ScAdded=''' + convert(varchar,@ScAdded) + ''', ';
	ELSE
		SET @SQL = @SQL + 'ScAdded=NULL, ';
END
IF (@ScMailOnDemandPostageTypeFlag Is Not NULL)
BEGIN
	IF (@ScMailOnDemandPostageType Is Not NULL)
		SET @SQL = @SQL + 'ScMailOnDemandPostageType=' + convert(varchar,@ScMailOnDemandPostageType) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScMailOnDemandPostageType=NULL, ';
END
IF (@ScMailOnDemandPostageFeeFlag Is Not NULL)
BEGIN
	IF (@ScMailOnDemandPostageFee Is Not NULL)
		SET @SQL = @SQL + 'ScMailOnDemandPostageFee=' + convert(varchar,@ScMailOnDemandPostageFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'ScMailOnDemandPostageFee=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE ShoppingCart SET ' + Left(@SQL, Len(@SQL)-1) + ' Where ScId = ' + convert(varchar,@ScId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
