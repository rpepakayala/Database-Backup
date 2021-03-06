/****** Object:  UserDefinedFunction [dbo].[Get_FirstOrderDate]    Script Date: 5/15/2018 12:14:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE FUNCTION [dbo].[Get_FirstOrderDate]( 
@customerID int=null,
@ContactID int=null,
@franchiseID char(7)
)

RETURNS datetime AS  
BEGIN 

declare @ContactFirstOrderDate datetime

SET @ContactFirstOrderDate = [dbo].[Get_Contact_FirstOrderDate]( @ContactID, @franchiseID )

return COALESCE(@ContactFirstOrderDate,'1900-01-01')

/*
declare @FirstOrderDate datetime
declare @CustomerFirstOrderDate datetime

SET @CustomerFirstOrderDate = [dbo].[Get_Customer_FirstOrderDate]( @customerID, @franchiseID )

IF( @ContactFirstOrderDate IS NULL )
	SET @FirstOrderDate = @CustomerFirstOrderDate
ELSE IF( @CustomerFirstOrderDate IS NULL )
	SET @FirstOrderDate = @ContactFirstOrderDate
ELSE IF( @ContactFirstOrderDate < @CustomerFirstOrderDate )
	SET @FirstOrderDate = @ContactFirstOrderDate
ELSE 
	SET @FirstOrderDate = @CustomerFirstOrderDate
*/

END


GO
