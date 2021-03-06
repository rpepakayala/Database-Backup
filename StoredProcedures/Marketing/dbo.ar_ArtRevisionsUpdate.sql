/****** Object:  StoredProcedure [dbo].[ar_ArtRevisionsUpdate]    Script Date: 5/15/2018 12:10:08 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE ar_ArtRevisionsUpdate
(
	@WebNumber int,
	@ArtTypeID int,
	@ArtRevisionStatusID int,
	@LastUpdated datetime,
	@transactionID int
)
AS
UPDATE ar_ArtRevisions
SET
	ArtRevisionStatusID = @ArtRevisionStatusID,
	LastUpdated = @LastUpdated,
	transactionID = @transactionID
WHERE
	WebNumber = @WebNumber
AND
	ArtTypeID = @ArtTypeID
GO
