/****** Object:  UserDefinedFunction [dbo].[Get_LastProduct]    Script Date: 5/15/2018 12:14:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE FUNCTION [dbo].[Get_LastProduct]( 
@customerID int=null,
@ContactID int=null,
@franchiseID char(7)
)

RETURNS varchar(100) AS  
BEGIN 

declare @LastProduct varchar(100)
SET @LastProduct = [dbo].[Get_Contact_LastProduct]( @ContactID, @franchiseID )
return COALESCE(@LastProduct,'')

/*
declare @LastProduct varchar(100)
declare @ContactLastOrderDate datetime
declare @CustomerLastOrderDate datetime

SET @ContactLastOrderDate = [dbo].[Get_Contact_LastOrderDate]( @ContactID, @franchiseID )
SET @CustomerLastOrderDate = [dbo].[Get_Customer_LastOrderDate]( @customerID, @franchiseID )

SET @ContactLastOrderDate = COALESCE(@ContactLastOrderDate,'1900-01-01')
SET @CustomerLastOrderDate = COALESCE(@CustomerLastOrderDate,'1900-01-01')

IF( @ContactLastOrderDate > @CustomerLastOrderDate )
	SET @LastProduct = [dbo].[Get_Contact_LastProduct]( @ContactID, @franchiseID )
else
	SET @LastProduct = [dbo].[Get_Customer_LastProduct]( @customerID, @franchiseID )

return COALESCE(@LastProduct,'')
*/
END


GO
