/****** Object:  StoredProcedure [dbo].[GetValidMailingYears]    Script Date: 5/15/2018 12:10:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.GetValidMailingYears AS
Select Distinct YEAR(MatGDMailDate) as MailingYear from MaterialGroupsDtl


GO
