/****** Object:  StoredProcedure [dbo].[VendorDelete]    Script Date: 5/15/2018 12:10:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.VendorDelete
(
	@VndId int
)
AS
	DELETE FROM Vendor WHERE VndId=@VndId;
RETURN @@Rowcount;


GO
