/****** Object:  View [dbo].[sysmail_sentitems]    Script Date: 5/15/2018 12:14:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE VIEW sysmail_sentitems
AS
SELECT * FROM msdb.dbo.sysmail_allitems WHERE sent_status = 'sent'


GO
