/****** Object:  View [dbo].[sysmail_faileditems]    Script Date: 5/15/2018 12:14:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE VIEW sysmail_faileditems
AS
SELECT * FROM msdb.dbo.sysmail_allitems WHERE sent_status = 'failed'


GO
