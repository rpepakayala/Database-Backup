/****** Object:  StoredProcedure [dbo].[VendorFeesUpdate]    Script Date: 5/15/2018 12:10:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.VendorFeesUpdate
(
	@VendorId int = NULL,
	@VfConstId int = NULL,
	@VfQty int = NULL,
	@VfQtyFlag bit = NULL,
	@VfQtyFee real = NULL,
	@VfQtyFeeFlag bit = NULL,
	@VfExtraFee real = NULL,
	@VfExtraFeeFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@VfQtyFlag Is Not NULL)
BEGIN
	IF (@VfQty Is Not NULL)
		SET @SQL = @SQL + 'VfQty=' + convert(varchar,@VfQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'VfQty=NULL, ';
END
IF (@VfQtyFeeFlag Is Not NULL)
BEGIN
	IF (@VfQtyFee Is Not NULL)
		SET @SQL = @SQL + 'VfQtyFee=' + convert(varchar,@VfQtyFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'VfQtyFee=NULL, ';
END
IF (@VfExtraFeeFlag Is Not NULL)
BEGIN
	IF (@VfExtraFee Is Not NULL)
		SET @SQL = @SQL + 'VfExtraFee=' + convert(varchar,@VfExtraFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'VfExtraFee=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE VendorFees SET ' + Left(@SQL, Len(@SQL)-1) + ' Where VendorId = ' + convert(varchar,@VendorId) + ' AND VfConstId = ' + convert(varchar,@VfConstId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
