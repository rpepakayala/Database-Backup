/****** Object:  View [dbo].[History_TransactionIDView]    Script Date: 5/15/2018 12:14:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW History_TransactionIDView AS SELECT Orig.ID, Orig.StoreID, Orig.ClassTypeID FROM TransHeader Orig WHERE ( TransactionType = 2 AND (  ( StatusID = 11 AND EstimateCreatedDate < CAST(CAST(40291.6500995486 AS Float) AS Integer) ) OR ( StatusID = 12 AND RejectedDate < CAST(CAST(40291.6500995486 AS Float) AS Integer) ) OR ( StatusID = 14 AND VoidedDate < CAST(CAST(40291.6500995486 AS Float) AS Integer) ) OR ( StatusID = 13 AND ConvertedDate < CAST(CAST(40291.6500995486 AS Float) AS Integer) )) )
GO
