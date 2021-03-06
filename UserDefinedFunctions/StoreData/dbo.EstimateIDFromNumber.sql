/****** Object:  UserDefinedFunction [dbo].[EstimateIDFromNumber]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION EstimateIDFromNumber (@EstimateNumber INT)
RETURNS INT
AS
BEGIN
  DECLARE @Result INT;
  SET @Result = (SELECT TOP 1 ID
                 FROM   TransHeader
                 WHERE  EstimateNumber = @EstimateNumber
                        AND TransactionType IN (2));
  Return(@Result);
END

GO
