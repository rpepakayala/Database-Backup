/****** Object:  View [dbo].[History_DetailIDList]    Script Date: 5/15/2018 12:14:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW History_DetailIDList AS SELECT TransDetail.ID FROM TransDetail WHERE TransDetail.TransHeaderID IN ( SELECT History_TransactionIDView.ID FROM History_TransactionIDView )
GO
