/****** Object:  UserDefinedFunction [dbo].[Get_Customer_LastProduct]    Script Date: 5/15/2018 12:14:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE FUNCTION [dbo].[Get_Customer_LastProduct]( 
@customerID int=null,
@franchiseID char(7)
)

RETURNS varchar(100) AS  
BEGIN 

declare @LastProduct varchar(100)

if ( @customerID is not null )
BEGIN
	select top 1 @LastProduct = o.Description 
	
	from [Order Database] o 
	
	Where o.SalesTotal is not null 
	and O.customerID = @customerID
	/* where the customer is given but the contact is NOT assigned 
	AND ( o.contactid = 0 OR o.contactid IS NULL ) */
	and o.zw_franchise_id = @franchiseID
	and o.customerid NOT IN ( select customerid from [dbo].[ExactTarget_InvalidCustomers](@franchiseID) )

	order by o.OrderDate desc
END

return  @LastProduct
END










GO
