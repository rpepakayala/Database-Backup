/****** Object:  StoredProcedure [dbo].[sp_getStores]    Script Date: 5/15/2018 12:10:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[sp_getStores]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT  CAST(a.UWEBNUMBER AS int) AS webnumber, CAST(a.KEY1 AS int) AS storenumber , 
	Key2 AS FBC, a.CITY, a.STATE, a.ZIP, CASE country WHEN '' THEN 'United States' ELSE country END AS country, 
	a.CONTACT, b.UREGION as region
	FROM MARYANN.Contact.dbo.Contact1 AS a LEFT OUTER JOIN MARYANN.Contact.dbo.Contact2 AS b 
	ON a.ACCOUNTNO = b.ACCOUNTNO

END

GO
