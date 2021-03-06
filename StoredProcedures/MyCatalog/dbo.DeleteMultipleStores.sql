/****** Object:  StoredProcedure [dbo].[DeleteMultipleStores]    Script Date: 5/15/2018 12:11:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		Steven Scott
-- Create date: 4/5/2018
-- Description:	Iterates over StoreIds in dbo.FIIStoresToDelete and calls dbo.DeleteStoreAndProducts for each store
-- =============================================
CREATE PROCEDURE [dbo].[DeleteMultipleStores] 
	-- Add the parameters for the stored procedure here

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @id int
	DECLARE @sId int


	SET ROWCOUNT 0

    SELECT * INTO #storestemp FROM FIIStoresToDelete

    SET ROWCOUNT 1

	SELECT @id = Id FROM #storestemp

    WHILE @@rowcount <> 0
      BEGIN

        SET ROWCOUNT 0

        SELECT * FROM #storestemp WHERE Id = @id

		SELECT @sId = StoreId FROM #storestemp WHERE Id = @id

		DECLARE @inUse int = -1

		SELECT  @inUse = Store.ParentStoreId
          FROM Store WHERE Store.ParentStoreId = @sId

		IF @inUse <= 0
		  EXEC DeleteStoreAndProducts @sId;

    
	    DELETE #storestemp WHERE Id = @id

        SET ROWCOUNT 1

        SELECT @Id = Id FROM #storestemp
    END

    SET ROWCOUNT 0

	END


GO
