/****** Object:  UserDefinedFunction [dbo].[PurchaseOrderFromNumber]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION PurchaseOrderFromNumber (@PurchaseOrderNumber INT)
RETURNS TABLE
AS
RETURN

SELECT TOP 1 *
FROM   TransHeader
WHERE  PurchaseOrderNumber = @PurchaseOrderNumber
       AND TransactionType IN (7);

GO
