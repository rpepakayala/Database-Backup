/****** Object:  UserDefinedFunction [dbo].[LedgerFromOrderNumber]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION LedgerFromOrderNumber (@OrderNumber INT)
RETURNS TABLE
AS
RETURN

SELECT *
FROM   Ledger
WHERE  TransactionID = dbo.OrderIDFromNumber(@OrderNumber)

GO
