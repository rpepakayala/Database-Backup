/****** Object:  StoredProcedure [dbo].[sub_SubsidyRemainingSelect]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE sub_SubsidyRemainingSelect
(
	@SHID int,
	@Year int,
	@StoreID int
)
 AS

SELECT StoreSubStartingAmount, 
	StoreSubRemainingAmount
FROM 
	StoreSubsidy
WHERE 
	StoreSubHid = @SHID
AND 
	StoreSubYear =@Year
AND 
	StoreSId = @StoreID
GO
