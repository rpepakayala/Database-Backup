/****** Object:  StoredProcedure [dbo].[sub_StoresinCoOp]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_StoresinCoOp
(
	@CoOpID int
)
AS
SELECT WebNumber
FROM CoOpStores
WHERE CoOpID = @CoOpID



GO
