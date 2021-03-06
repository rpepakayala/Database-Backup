/****** Object:  View [dbo].[sub_SingleStoresTotalsView]    Script Date: 5/15/2018 12:14:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[sub_SingleStoresTotalsView]
AS
SELECT DISTINCT totals.SourceID AS WebNumber, sub.Year,
                          (SELECT     t1.AmountAvailable
                            FROM          dbo.sub_Totals AS t1 INNER JOIN
                                                   dbo.sub_Subsidies AS s1 ON t1.SubsidyID = s1.SubsidyID
                            WHERE      (s1.CategoryID = 1) AND (t1.SubsidyTypeID = 1) AND (t1.SourceID = totals.SourceID) AND (s1.Year = sub.Year)) AS FastbucksAvailable,
                          (SELECT     t1.AmountAvailable
                            FROM          dbo.sub_Totals AS t1 INNER JOIN
                                                   dbo.sub_Subsidies AS s1 ON t1.SubsidyID = s1.SubsidyID
                            WHERE      (s1.CategoryID = 2) AND (t1.SubsidyTypeID = 1) AND (t1.SourceID = totals.SourceID) AND (s1.Year = sub.Year)) AS MediaAvailable,
                          (SELECT     t1.AmountEarned
                            FROM          dbo.sub_Totals AS t1 INNER JOIN
                                                   dbo.sub_Subsidies AS s1 ON t1.SubsidyID = s1.SubsidyID
                            WHERE      (s1.CategoryID = 1) AND (t1.SubsidyTypeID = 1) AND (t1.SourceID = totals.SourceID) AND (s1.Year = sub.Year)) AS FastbucksEarned,
                          (SELECT     t1.AmountEarned
                            FROM          dbo.sub_Totals AS t1 INNER JOIN
                                                   dbo.sub_Subsidies AS s1 ON t1.SubsidyID = s1.SubsidyID
                            WHERE      (s1.CategoryID = 2) AND (t1.SubsidyTypeID = 1) AND (t1.SourceID = totals.SourceID) AND (s1.Year = sub.Year)) AS MediaEarned,
                          (SELECT     t1.AmountAvailable
                            FROM          dbo.sub_Totals AS t1 INNER JOIN
                                                   dbo.sub_Subsidies AS s1 ON t1.SubsidyID = s1.SubsidyID
                            WHERE      (s1.CategoryID = 3) AND (t1.SubsidyTypeID = 1) AND (t1.SourceID = totals.SourceID) AND (s1.Year = sub.Year)) AS FMSPAvailable,
                          (SELECT     t1.AmountEarned
                            FROM          dbo.sub_Totals AS t1 INNER JOIN
                                                   dbo.sub_Subsidies AS s1 ON t1.SubsidyID = s1.SubsidyID
                            WHERE      (s1.CategoryID = 3) AND (t1.SubsidyTypeID = 1) AND (t1.SourceID = totals.SourceID) AND (s1.Year = sub.Year)) AS FMSPEarned
FROM         dbo.sub_Totals AS totals INNER JOIN
                      dbo.sub_Subsidies AS sub ON sub.SubsidyID = totals.SubsidyID AND totals.SubsidyTypeID = 1 INNER JOIN
                      dbo.Sub_Categories AS cat ON cat.CategoryID = sub.CategoryID

GO
