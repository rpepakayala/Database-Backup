/****** Object:  UserDefinedFunction [dbo].[GetStoreState]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Mark Zuerker
-- Create date: 12/18/2007
-- Description:	Returns the State for a given store number
-- =============================================
CREATE FUNCTION [dbo].[GetStoreState] 
(
	-- Add the parameters for the function here
	@StoreNumber int
)
RETURNS varchar(128)
AS
BEGIN
	Declare @Result varchar(128)
	select @Result=cpd.FullName
		from  cor_stores cs
		inner join cor_stores_addresses_link csal
			on cs.StoreID=csal.storeid
		inner join cor_addresses ca
			on csal.addressID=ca.addressid
		inner join cor_political_division cpd
			on ca.politicaldivisionid = cpd.politicaldivisionid
	where cs.storeNumber = @StoreNumber
	Return @Result
END


GO
