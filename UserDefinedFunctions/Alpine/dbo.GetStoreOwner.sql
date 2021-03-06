/****** Object:  UserDefinedFunction [dbo].[GetStoreOwner]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetStoreOwner] 
(
	@StoreID bigint
)
RETURNS varchar(101)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @owner varchar(101)

	-- Add the T-SQL statements to compute the return value here
	(select top 1 @owner=cp2.firstName + ' ' + cp2.lastName  from 
			cor_stores_persons_link cpl2
             inner join cor_persons cp2 on cpl2.personid = cp2.personid
             where cpl2.StoreID=@StoreID and cpl2.goldmineplacement = 0)

	-- Return the result of the function
	RETURN @owner

END


GO
