/****** Object:  StoredProcedure [dbo].[OrderOffersDelete]    Script Date: 5/15/2018 12:10:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderOffersDelete
(
	@OrdHid int,
	@OrdPSId int,
	@OrdOffId int
)
AS
	DELETE FROM OrderOffers WHERE OrdHid=@OrdHid AND OrdPSId=@OrdPSId AND OrdOffId=@OrdOffId;
RETURN @@Rowcount;


GO
