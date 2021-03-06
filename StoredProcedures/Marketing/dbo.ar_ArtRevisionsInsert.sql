/****** Object:  StoredProcedure [dbo].[ar_ArtRevisionsInsert]    Script Date: 5/15/2018 12:10:08 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF



CREATE PROCEDURE ar_ArtRevisionsInsert
(
	@WebNumber int,
	@ArtTypeID int,
	@ArtRevisionStatusID int,
	@transactionID int,
	@LastUpdated datetime
)
AS
INSERT INTO ar_ArtRevisions
(
	WebNumber,
	ArtTypeID,
	ArtRevisionStatusID,
	TransactionID,
	LastUpdated
)
VALUES
(
	@WebNumber,
	@ArtTypeID,
	@ArtRevisionStatusID,
	@transactionID,
	@LastUpdated
)
GO
