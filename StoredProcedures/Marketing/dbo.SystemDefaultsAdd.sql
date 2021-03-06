/****** Object:  StoredProcedure [dbo].[SystemDefaultsAdd]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SystemDefaultsAdd
(
	@SystemDefaultsId int = NULL,
	@StoreImagePath varchar(250) = NULL,
	@ImagePath varchar(250) = NULL,
	@FilePath varchar(250) = NULL,
	@DBPath varchar(250) = NULL,
	@ProofPath varchar(250) = NULL,
	@SignUpDeadline smallint = NULL,
	@UploadDBDeadline smallint = NULL,
	@CreditCardValidation smallint = NULL,
	@PlanSignUpDeadline smallint = NULL,
	@DeclineOrderDeadline smallint = NULL,
	@OperationalStatusValue varchar(20) = NULL,
	@DBNotUploadedNotificationDays smallint = NULL,
	@MailOrderDeclinedNotificationDays smallint = NULL,
	@MaterialOrderDeclinedNotificationDays smallint = NULL,
	@OrderNotFulfilledNotificationDays smallint = NULL,
	@CreditCardExpirationDeadline smallint = NULL
)
AS
INSERT INTO SystemDefaults (SystemDefaultsId, StoreImagePath, ImagePath, FilePath, DBPath, ProofPath, SignUpDeadline, UploadDBDeadline, CreditCardValidation, PlanSignUpDeadline, DeclineOrderDeadline, OperationalStatusValue, DBNotUploadedNotificationDays, MailOrderDeclinedNotificationDays, MaterialOrderDeclinedNotificationDays, OrderNotFulfilledNotificationDays, CreditCardExpirationDeadline)
 VALUES (@SystemDefaultsId, @StoreImagePath, @ImagePath, @FilePath, @DBPath, @ProofPath, @SignUpDeadline, @UploadDBDeadline, @CreditCardValidation, @PlanSignUpDeadline, @DeclineOrderDeadline, @OperationalStatusValue, @DBNotUploadedNotificationDays, @MailOrderDeclinedNotificationDays, @MaterialOrderDeclinedNotificationDays, @OrderNotFulfilledNotificationDays, @CreditCardExpirationDeadline);


GO
