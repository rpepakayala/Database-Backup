/****** Object:  View [dbo].[GL]    Script Date: 5/15/2018 12:14:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW GL AS SELECT * From Ledger with(nolock) where OffBalanceSheet = 0

GO
