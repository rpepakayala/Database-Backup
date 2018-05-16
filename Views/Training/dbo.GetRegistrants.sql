/****** Object:  View [dbo].[GetRegistrants]    Script Date: 5/15/2018 12:14:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW dbo.GetRegistrants
AS
SELECT     R.FirstName, R.LastName, M.Title, S.StartDate, R.FBCTradeOut, R.FBCName
FROM         dbo.Registrants R INNER JOIN
                      dbo.SubClasses S ON R.SubClass = S.ID INNER JOIN
                      dbo.MasterClasses M ON S.MasterClass = M.ID



GO
