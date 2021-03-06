/****** Object:  StoredProcedure [dbo].[OrderPaymentSummView]    Script Date: 5/15/2018 12:10:21 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.OrderPaymentSummView
(
	@OrigOrdHID  int,
	@OrdHID  int = NULL
)
AS
	SET NOCOUNT ON
	DECLARE @StoreID int
	DECLARE @PaymentName varchar(50)
	CREATE TABLE #tt(PaymentTypeID int, PaymentName varchar(50), SubHId int, OrigPaymentAmount float, PaymentAmount float, Comments varchar(255))
	SELECT @PaymentName = CASE OrdPmType WHEN 1 THEN 'Check' WHEN 2 THEN 'Credit Card' ELSE 'Unknown' END
	FROM OrderPayment op
	INNER JOIN OrderHdr oh ON (oh.OrdHId = op.OrdHId)
	WHERE oh.OrdHId = @OrigOrdHID
	INSERT INTO #tt(PaymentTypeID, PaymentName, OrigPaymentAmount)
	SELECT 1, @PaymentName, SUM(OrdPmAmount)
	FROM OrderPayment
	WHERE OrdHId = @OrigOrdHID OR OrdHId IN (SELECT OrdHId FROM OrderHdr WHERE OrdHOrigOrderId = @OrigOrdHID)
	INSERT INTO #tt(PaymentTypeID, SubHId)
	SELECT DISTINCT 2, SubLHId
	FROM SubsidyLog
	WHERE SubLOrdHId = @OrigOrdHID
	UPDATE #tt
		SET OrigPaymentAmount = (SELECT SUM(SubLAmount)
					FROM SubsidyLog
					WHERE SubLHId = #tt.SubHId AND (SubLOrdHId = @OrigOrdHID OR SubLOrdHId in (SELECT OrdHId FROM OrderHdr WHERE OrdHOrigOrderId = @OrigOrdHID))),
			PaymentName = (SELECT SubHDesc FROM SubsidyHdr WHERE SubHId = #tt.SubHId)
	WHERE PaymentTypeID = 2 AND SubHId IS NOT NULL
	IF (@OrdHID IS NOT NULL)
	BEGIN
		UPDATE #tt
			SET PaymentAmount = (SELECT OrdPmAmount
						FROM OrderPayment
						WHERE OrdHId = @OrdHID),
				Comments = (SELECT OrdHDesc
						FROM OrderHdr
						WHERE OrdHId = @OrdHID)
		WHERE PaymentTypeID = 1
		UPDATE #tt
			SET PaymentAmount = (SELECT SubLAmount
						FROM SubsidyLog
						WHERE SubLHId = #tt.SubHId AND SubLOrdHId = @OrdHID)
		WHERE PaymentTypeID = 2 AND SubHId IS NOT NULL
	END
	SELECT * FROM #tt
	ORDER BY PaymentTypeID
	DROP TABLE #tt
	;


GO
