/****** Object:  StoredProcedure [dbo].[Cyrious_storeID_sel_all_transformable]    Script Date: 5/15/2018 12:09:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[Cyrious_storeID_sel_all_transformable]
AS
SET NOCOUNT ON

select zw_franchise_id, max(storeid) as StoreID
from [store information database]
WHERE zw_franchise_id NOT IN (
	select zw_franchise_id
	from [customer type database]
	group by zw_franchise_id
	having max(customertypeid) = -1
)
and LTRIM(RTRIM(zw_franchise_id)) NOT IN ( '', 'fsi9999', 'fsiBART', 'fsiTEST', 'fsi0908' )
group by zw_franchise_id
order by zw_franchise_id





GO
