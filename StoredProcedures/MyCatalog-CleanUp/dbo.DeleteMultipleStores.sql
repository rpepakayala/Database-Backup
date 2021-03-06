/****** Object:  StoredProcedure [dbo].[DeleteMultipleStores]    Script Date: 5/15/2018 12:11:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		Steven Scott
-- Create date: 4/5/2018
-- Description:	Iterates over StoreIds in dbo.FIIStoresToDelete and calls dbo.DeleteStoreAndProducts for each store
-- =============================================
CREATE PROCEDURE [dbo].[DeleteMultipleStores] 
/* TODO:
Msg 547, Level 16, State 0, Procedure DeleteStoreAndProducts, Line 79
The DELETE statement conflicted with the REFERENCE constraint "Customer_BillingAddress". The conflict occurred in database "MyCatalog-CleanUp", table "dbo.Customer", column 'BillingAddress_Id'.
The statement has been terminated.
Msg 547, Level 16, State 0, Procedure DeleteStoreAndProducts, Line 100
The DELETE statement conflicted with the REFERENCE constraint "Store_Addresses". The conflict occurred in database "MyCatalog-CleanUp", table "dbo.Address", column 'Store_Id'.
The statement has been terminated.
Msg 547, Level 16, State 0, Procedure DeleteStoreAndProducts, Line 90
The DELETE statement conflicted with the REFERENCE constraint "Log_Customer". The conflict occurred in database "MyCatalog-CleanUp", table "dbo.Log", column 'CustomerId'.
The statement has been terminated.
Msg 547, Level 16, State 0, Procedure DeleteStoreAndProducts, Line 100
The DELETE statement conflicted with the REFERENCE constraint "Customer_Store". The conflict occurred in database "MyCatalog-CleanUp", table "dbo.Customer", column 'StoreId'.
The statement has been terminated.
*/

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
