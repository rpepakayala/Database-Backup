/****** Object:  StoredProcedure [dbo].[RMPHdrAdd]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.RMPHdrAdd
(
	@RMPHId int = NULL,
	@RMPHName varchar(50) = NULL,
	@RMPHDescription varchar(250) = NULL,
	@RMPHDisabled char(1) = NULL,
	@RMPHHidden char(1) = NULL
)
AS
INSERT INTO RMPHdr (RMPHId, RMPHName, RMPHDescription, RMPHDisabled, RMPHHidden)
 VALUES (@RMPHId, @RMPHName, @RMPHDescription, @RMPHDisabled, @RMPHHidden);


GO
