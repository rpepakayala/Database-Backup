/****** Object:  StoredProcedure [dbo].[GetJobDefaultDetail]    Script Date: 5/15/2018 12:13:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetJobDefaultDetail]
	@JobID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT JobId, OriginalFilename, ps.StateLabel
	FROM Proof p (NOLOCK)
	INNER JOIN ProofState ps (NOLOCK) ON p.ProofStateId = ps.ProofStateId
	WHERE JobId = @JobID
END

GO
