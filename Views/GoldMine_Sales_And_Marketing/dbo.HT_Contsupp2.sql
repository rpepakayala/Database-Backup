/****** Object:  View [dbo].[HT_Contsupp2]    Script Date: 5/15/2018 12:13:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE VIEW [dbo].[HT_Contsupp2]
AS
select
	cs.accountno,
	cs.contsupref + isnull(cs.address1,'') as 'EMail'
	from contsupp cs
	where cs.rectype = 'P' and cs.contact = 'E-mail Address'




GO
