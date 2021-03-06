/****** Object:  StoredProcedure [dbo].[Cyrious_storeID_sel_all]    Script Date: 5/15/2018 12:09:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[Cyrious_storeID_sel_all]
AS
SET NOCOUNT ON

/* alternate order by even/odd days */
if( ( datepart(d,getdate()) % 2 ) = 1 )

	select zw_franchise_id, max(storeid) as StoreID
	from [store information database]
	WHERE LTRIM(RTRIM(zw_franchise_id)) NOT IN ( '', 'fsi9999', 'fsiBART', 'fsiTEST' )
	group by zw_franchise_id
	order by zw_franchise_id

ELSE

	select zw_franchise_id, max(storeid) as StoreID
	from [store information database]
	WHERE LTRIM(RTRIM(zw_franchise_id)) NOT IN ( '', 'fsi9999', 'fsiBART', 'fsiTEST' )
	group by zw_franchise_id
	order by zw_franchise_id DESC

GO
