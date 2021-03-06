/****** Object:  StoredProcedure [dbo].[SubsidyHdrAdd]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SubsidyHdrAdd
(
	@SubHId int = NULL,
	@SubHType tinyint = NULL,
	@SubHDesc varchar(50) = NULL,
	@SubHMrktCountry smallint = NULL,
	@SubHDisable char(1) = NULL,
	@CoOpOnly bit = NULL
)
AS
INSERT INTO SubsidyHdr (SubHId, SubHType, SubHDesc, SubHMrktCountry, SubHDisable, CoOpOnly)
 VALUES (@SubHId, @SubHType, @SubHDesc, @SubHMrktCountry, @SubHDisable, @CoOpOnly);


GO
