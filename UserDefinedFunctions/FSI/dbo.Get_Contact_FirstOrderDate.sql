/****** Object:  UserDefinedFunction [dbo].[Get_Contact_FirstOrderDate]    Script Date: 5/15/2018 12:14:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE FUNCTION [dbo].[Get_Contact_FirstOrderDate]( 
@contactID int=null,
@franchiseID char(7)
)

RETURNS datetime AS  
BEGIN 

declare @FirstOrderDate datetime

if ( @contactID is not null )
BEGIN
	select @FirstOrderDate = min(o.OrderDate)
	
	from [Order Database] o 
	
	Where o.SalesTotal is not null 
	and O.contactID = @contactID
	and o.zw_franchise_id = @franchiseID
END

return  @FirstOrderDate
END








GO
