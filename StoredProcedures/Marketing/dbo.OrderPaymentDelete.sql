/****** Object:  StoredProcedure [dbo].[OrderPaymentDelete]    Script Date: 5/15/2018 12:10:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderPaymentDelete
(
	@OrdHId int,
	@OrdPmId int
)
AS
	DELETE FROM OrderPayment WHERE OrdHId=@OrdHId AND OrdPmId=@OrdPmId;
RETURN @@Rowcount;


GO
