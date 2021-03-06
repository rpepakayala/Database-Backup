/****** Object:  UserDefinedFunction [dbo].[OrderIDFromNumber]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION OrderIDFromNumber (@OrderNumber INT)
RETURNS INT
AS
BEGIN
  DECLARE @Result INT;
  SET @Result = (SELECT TOP 1 ID
                 FROM   TransHeader
                 WHERE  OrderNumber = @OrderNumber
                        AND TransactionType IN (1,4,6));
  Return(@Result);
END

GO
