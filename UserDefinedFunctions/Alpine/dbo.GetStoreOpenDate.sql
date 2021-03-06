/****** Object:  UserDefinedFunction [dbo].[GetStoreOpenDate]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Mark Zuerker
-- Create date: 6/3/2008
-- Description:	Pulls Back the latest date
--				Either the open date or the latest 
--				Resale date
-- =============================================
CREATE FUNCTION [dbo].[GetStoreOpenDate] 
(
	@StoreNumber int
)
RETURNS datetime
AS
BEGIN
	Declare @BeginDate datetime
	select top 1 @BeginDate=CSD.begindate--,BSTatus.Description,EStatus.Description
		from COR_STORE_DATES csd
		inner join COR_STORES s
			on csd.storeid=s.storeid
		inner join COR_STORE_STATUS_TYPES BSTATUS
			on csd.BeginStatus=BSTATUS.StoreStatusType
		inner join COR_STORE_STATUS_TYPES ESTATUS
			on csd.EndStatus=ESTATUS.StoreStatusType
		Where s.StoreNumber=@Storenumber
			and csd.Beginstatus in (3004,3002)
		order by BeginDate desc, csd.BeginStatus, EndingDate desc

	-- Return the result of the function
	RETURN @BeginDate

END


GO
