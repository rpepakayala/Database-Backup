/****** Object:  View [dbo].[TransHistoryView]    Script Date: 5/15/2018 12:14:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW TransHistoryView AS SELECT Orig.ID, Orig.StoreID, Orig.ClassTypeID FROM TransHeader Orig WHERE ( TransactionType = 2 AND (  ( StatusID = 11 AND EstimateCreatedDate < CAST(CAST(38239.5794057407 AS Float) AS Integer) ) OR ( StatusID = 12 AND RejectedDate < CAST(CAST(38239.5794057407 AS Float) AS Integer) ) OR ( StatusID = 14 AND VoidedDate < CAST(CAST(38239.5794057407 AS Float) AS Integer) ) OR ( StatusID = 13 AND ConvertedDate < CAST(CAST(38239.5794057407 AS Float) AS Integer) )) )
GO
