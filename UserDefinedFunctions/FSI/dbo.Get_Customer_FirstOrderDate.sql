/****** Object:  UserDefinedFunction [dbo].[Get_Customer_FirstOrderDate]    Script Date: 5/15/2018 12:14:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE FUNCTION [dbo].[Get_Customer_FirstOrderDate]( 
@customerID int=null,
@franchiseID char(7)
)

RETURNS datetime AS  
BEGIN 

declare @FirstOrderDate datetime

if ( @customerID is not null )
BEGIN
	select  @FirstOrderDate = min(o.OrderDate)
	
	from [Order Database] o 
	
	Where o.SalesTotal is not null 
	and O.customerID = @customerID
	/* where the customer is given but the contact is NOT assigned 
	AND ( o.contactid = 0 OR o.contactid IS NULL ) */
	and o.zw_franchise_id = @franchiseID
	and o.customerid NOT IN ( select customerid from [dbo].[ExactTarget_InvalidCustomers](@franchiseID) )
END

return  @FirstOrderDate
END











GO
