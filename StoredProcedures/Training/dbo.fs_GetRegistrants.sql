/****** Object:  StoredProcedure [dbo].[fs_GetRegistrants]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE fs_GetRegistrants
AS
SELECT     R.FirstName, R.LastName, M.Title, S.StartDate, R.FBCTradeOut, R.FBCName
FROM         dbo.Registrants R INNER JOIN
                      dbo.SubClasses S ON R.SubClass = S.ID INNER JOIN
                      dbo.MasterClasses M ON S.MasterClass = M.ID

GO
