/****** Object:  UserDefinedFunction [dbo].[getARTotals]    Script Date: 5/15/2018 12:15:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getARTotals]
(
	-- Add the parameters for the function here
	@Franchise varchar(32)
)
RETURNS  money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Total MONEY
SELECT @Total = ((sum(amount_due) + sum(tax)) - sum(amount_paid))
 FROM
invoices i 
JOIN invoice_line_items ili ON ili.invoice_id = i.invoice_id
WHERE 
franchise_id=@Franchise
 and
paid_on is NULL
AND sequence > 0
GROUP BY franchise_id

	RETURN @total

END

GO
