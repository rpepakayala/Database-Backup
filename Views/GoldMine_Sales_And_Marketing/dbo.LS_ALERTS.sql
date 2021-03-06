/****** Object:  View [dbo].[LS_ALERTS]    Script Date: 5/15/2018 12:13:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[LS_ALERTS]
AS
SELECT [dbo].[CONTSUPP].[ACCOUNTNO], LS = 'Advertising'
FROM [dbo].[CONTSUPP]
WHERE rectype = 'A' AND notes LIKE '%~LSA%'
UNION
SELECT [dbo].[CONTSUPP].[ACCOUNTNO], LS = 'Decor'
FROM [dbo].[CONTSUPP]
WHERE rectype = 'A' AND notes LIKE '%~LSD%'
UNION
SELECT [dbo].[CONTSUPP].[ACCOUNTNO], LS = 'Insurance'
FROM [dbo].[CONTSUPP]
WHERE rectype = 'A' AND notes LIKE '%~LSI%'
UNION
SELECT [dbo].[CONTSUPP].[ACCOUNTNO], LS = 'Operational'
FROM [dbo].[CONTSUPP]
WHERE rectype = 'A' AND notes LIKE '%~LSO%'
UNION
SELECT [dbo].[CONTSUPP].[ACCOUNTNO], LS = 'Royalties'
FROM [dbo].[CONTSUPP]
WHERE rectype = 'A' AND notes LIKE '%~LSR%'
UNION
SELECT [dbo].[CONTSUPP].[ACCOUNTNO], LS = 'Trademark'
FROM [dbo].[CONTSUPP]
WHERE rectype = 'A' AND notes LIKE '%~LST%'



GO
