/****** Object:  UserDefinedFunction [dbo].[CorebridgeOrderFromInvoice]    Script Date: 5/15/2018 12:14:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		TAF
-- Create date: 8/24/2015
-- Description:	Returns Order Number from Corebridge
--			Voids will return a '-V' at the end
-- =============================================
CREATE FUNCTION CorebridgeOrderFromInvoice 
(
	@InvoiceNumber VARCHAR(200)
)
RETURNS VARCHAR(20)
AS
BEGIN
	RETURN SUBSTRING(@InvoiceNumber,dbo.at('-',@InvoiceNumber,1)+1,10)
END

GO
