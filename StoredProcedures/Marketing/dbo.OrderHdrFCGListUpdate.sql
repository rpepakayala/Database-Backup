/****** Object:  StoredProcedure [dbo].[OrderHdrFCGListUpdate]    Script Date: 5/15/2018 12:10:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE OrderHdrFCGListUpdate
(
	@OrdHId int
)
AS
UPDATE OrderHdr
SET OrdHFCGList = 1
WHERE OrdHId = @OrdHId



GO
