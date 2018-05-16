/****** Object:  StoredProcedure [dbo].[sub_ListStoresWithAmountsByYear]    Script Date: 5/15/2018 12:10:27 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_ListStoresWithAmountsByYear
(
	@Year int
)
AS
SELECT DISTINCT
	StoreSId
	--StoreSubYear,
	--StoreSubHid,
	--StoreSubType,
	--StoreSubStartingAmount,
	--StoreSubRemainingAmount
FROM	
	StoreSubsidy
WHERE 
	StoreSubYear = @Year



GO
