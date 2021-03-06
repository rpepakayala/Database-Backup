/****** Object:  StoredProcedure [dbo].[StoreSubsidyAdd]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.StoreSubsidyAdd
(
	@StoreSId int = NULL,
	@StoreSubYear smallint = NULL,
	@StoreSubHId int = NULL,
	@StoreSubType tinyint = NULL,
	@StoreSubStartingAmount float = NULL,
	@StoreSubRemainingAmount float = NULL
)
AS
INSERT INTO StoreSubsidy (StoreSId, StoreSubYear, StoreSubHId, StoreSubType, StoreSubStartingAmount, StoreSubRemainingAmount)
 VALUES (@StoreSId, @StoreSubYear, @StoreSubHId, @StoreSubType, @StoreSubStartingAmount, @StoreSubRemainingAmount);


GO
