/****** Object:  View [dbo].[spt_values]    Script Date: 5/15/2018 12:14:04 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

create view spt_values as
select name collate database_default as name,
	number,
	type collate database_default as type,
	low, high, status
from sys.spt_values

GO
