/****** Object:  UserDefinedFunction [dbo].[Get_Contact_LastOrderAmount]    Script Date: 5/15/2018 12:14:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE FUNCTION [dbo].[Get_Contact_LastOrderAmount]( 
@contactID int=null,
@franchiseID char(7)
)

RETURNS money AS  
BEGIN 

declare @LastOrderAmount money

if ( @contactID is not null )
BEGIN
	select top 1 @LastOrderAmount = o.SalesTotal 
	
	from [Order Database] o 
	
	Where o.SalesTotal is not null 
	and O.contactID = @contactID
	and o.zw_franchise_id = @franchiseID

	order by o.OrderDate desc
END

return  @LastOrderAmount
END







GO
