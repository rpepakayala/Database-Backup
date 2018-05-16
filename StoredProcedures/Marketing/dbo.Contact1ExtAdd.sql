/****** Object:  StoredProcedure [dbo].[Contact1ExtAdd]    Script Date: 5/15/2018 12:10:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.Contact1ExtAdd
(
	@Contact1ExtID int = NULL,
	@Contact1UWEBNUMBER int = NULL,
	@Contact1ExtAcceptChecks char(1) = NULL
)
AS
INSERT INTO Contact1Ext (Contact1ExtID, Contact1UWEBNUMBER, Contact1ExtAcceptChecks)
 VALUES (@Contact1ExtID, @Contact1UWEBNUMBER, @Contact1ExtAcceptChecks);


GO
