/****** Object:  View [dbo].[sysdtslog90]    Script Date: 5/15/2018 12:14:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[sysdtslog90]
AS
	SELECT [id]
		  ,[event]
		  ,[computer]
		  ,[operator]
		  ,[source]
		  ,[sourceid]
		  ,[executionid]
		  ,[starttime]
		  ,[endtime]
		  ,[datacode]
		  ,[databytes]
		  ,[message]
	  FROM [msdb].[dbo].[sysssislog]


GO
