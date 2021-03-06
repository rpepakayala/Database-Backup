/****** Object:  UserDefinedFunction [dbo].[GetStoreDirector]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetStoreDirector] 
(
	@StoreID bigint
)
RETURNS varchar(101)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @director varchar(101)

	-- Add the T-SQL statements to compute the return value here
	(select top 1 @director=FirstName + ' ' + LastName 
         from cor_stores_persons_link cs2
         inner join cor_persons cp on cs2.PersonID = cp.PersonID 
         where cs2.StoreID=@StoreID
		 and cp.PersonType = 2006)

	-- Return the result of the function
	RETURN @director

END


GO
