/****** Object:  StoredProcedure [dbo].[OffersAdd]    Script Date: 5/15/2018 12:10:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OffersAdd
(
	@OffId int = NULL,
	@OffType tinyint = NULL,
	@OffName varchar(50) = NULL,
	@OffImage varchar(50) = NULL,
	@OffDisabled char(1) = NULL
)
AS
INSERT INTO Offers (OffId, OffType, OffName, OffImage, OffDisabled)
 VALUES (@OffId, @OffType, @OffName, @OffImage, @OffDisabled);


GO
