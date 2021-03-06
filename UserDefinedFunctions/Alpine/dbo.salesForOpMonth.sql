/****** Object:  UserDefinedFunction [dbo].[salesForOpMonth]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


/*********************************************
*
* new Function
*
**********************************************/

CREATE FUNCTION [dbo].[salesForOpMonth]
(
	-- Add the parameters for the function here
	@opmonth smallint, @storeId smallint
)
RETURNS float
AS
BEGIN
	
	declare @sales float
	select @sales = sum(TotalSales) 
				 from sls_royalty_report r 
				 inner join sls_royalty_period p on r.RoyaltyPeriodID = p.RoyaltyPeriodID 				
				 where r.OperatingMonth = @opmonth
				 and p.StoreId = @storeId
	return @sales

END



GO
