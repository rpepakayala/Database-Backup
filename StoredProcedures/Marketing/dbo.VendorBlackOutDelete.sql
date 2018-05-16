/****** Object:  StoredProcedure [dbo].[VendorBlackOutDelete]    Script Date: 5/15/2018 12:10:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.VendorBlackOutDelete
(
	@VendorId int,
	@VboMonth tinyint,
	@VboDay tinyint
)
AS
	DELETE FROM VendorBlackOut WHERE VendorId=@VendorId AND VboMonth=@VboMonth AND VboDay=@VboDay;
RETURN @@Rowcount;


GO
