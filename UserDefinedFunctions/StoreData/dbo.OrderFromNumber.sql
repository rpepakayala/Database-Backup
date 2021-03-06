/****** Object:  UserDefinedFunction [dbo].[OrderFromNumber]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION OrderFromNumber (@OrderNumber INT)
RETURNS TABLE
AS
RETURN

SELECT TOP 1 *
FROM   TransHeader
WHERE  OrderNumber = @OrderNumber
       AND TransactionType IN (1,4,6);

GO
