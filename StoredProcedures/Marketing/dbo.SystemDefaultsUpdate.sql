/****** Object:  StoredProcedure [dbo].[SystemDefaultsUpdate]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SystemDefaultsUpdate
(
	@SystemDefaultsId int = NULL,
	@StoreImagePath varchar(250) = NULL,
	@StoreImagePathFlag bit = NULL,
	@ImagePath varchar(250) = NULL,
	@ImagePathFlag bit = NULL,
	@FilePath varchar(250) = NULL,
	@FilePathFlag bit = NULL,
	@DBPath varchar(250) = NULL,
	@DBPathFlag bit = NULL,
	@ProofPath varchar(250) = NULL,
	@ProofPathFlag bit = NULL,
	@SignUpDeadline smallint = NULL,
	@SignUpDeadlineFlag bit = NULL,
	@UploadDBDeadline smallint = NULL,
	@UploadDBDeadlineFlag bit = NULL,
	@CreditCardValidation smallint = NULL,
	@CreditCardValidationFlag bit = NULL,
	@PlanSignUpDeadline smallint = NULL,
	@PlanSignUpDeadlineFlag bit = NULL,
	@DeclineOrderDeadline smallint = NULL,
	@DeclineOrderDeadlineFlag bit = NULL,
	@OperationalStatusValue varchar(20) = NULL,
	@OperationalStatusValueFlag bit = NULL,
	@DBNotUploadedNotificationDays smallint = NULL,
	@DBNotUploadedNotificationDaysFlag bit = NULL,
	@MailOrderDeclinedNotificationDays smallint = NULL,
	@MailOrderDeclinedNotificationDaysFlag bit = NULL,
	@MaterialOrderDeclinedNotificationDays smallint = NULL,
	@MaterialOrderDeclinedNotificationDaysFlag bit = NULL,
	@OrderNotFulfilledNotificationDays smallint = NULL,
	@OrderNotFulfilledNotificationDaysFlag bit = NULL,
	@CreditCardExpirationDeadline smallint = NULL,
	@CreditCardExpirationDeadlineFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@StoreImagePathFlag Is Not NULL)
BEGIN
	IF (@StoreImagePath Is Not NULL)
		SET @SQL = @SQL + 'StoreImagePath=''' + @StoreImagePath + ''', ';
	ELSE
		SET @SQL = @SQL + 'StoreImagePath=NULL, ';
END
IF (@ImagePathFlag Is Not NULL)
BEGIN
	IF (@ImagePath Is Not NULL)
		SET @SQL = @SQL + 'ImagePath=''' + @ImagePath + ''', ';
	ELSE
		SET @SQL = @SQL + 'ImagePath=NULL, ';
END
IF (@FilePathFlag Is Not NULL)
BEGIN
	IF (@FilePath Is Not NULL)
		SET @SQL = @SQL + 'FilePath=''' + @FilePath + ''', ';
	ELSE
		SET @SQL = @SQL + 'FilePath=NULL, ';
END
IF (@DBPathFlag Is Not NULL)
BEGIN
	IF (@DBPath Is Not NULL)
		SET @SQL = @SQL + 'DBPath=''' + @DBPath + ''', ';
	ELSE
		SET @SQL = @SQL + 'DBPath=NULL, ';
END
IF (@ProofPathFlag Is Not NULL)
BEGIN
	IF (@ProofPath Is Not NULL)
		SET @SQL = @SQL + 'ProofPath=''' + @ProofPath + ''', ';
	ELSE
		SET @SQL = @SQL + 'ProofPath=NULL, ';
END
IF (@SignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@SignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'SignUpDeadline=' + convert(varchar,@SignUpDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'SignUpDeadline=NULL, ';
END
IF (@UploadDBDeadlineFlag Is Not NULL)
BEGIN
	IF (@UploadDBDeadline Is Not NULL)
		SET @SQL = @SQL + 'UploadDBDeadline=' + convert(varchar,@UploadDBDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'UploadDBDeadline=NULL, ';
END
IF (@CreditCardValidationFlag Is Not NULL)
BEGIN
	IF (@CreditCardValidation Is Not NULL)
		SET @SQL = @SQL + 'CreditCardValidation=' + convert(varchar,@CreditCardValidation) + ', ';
	ELSE
		SET @SQL = @SQL + 'CreditCardValidation=NULL, ';
END
IF (@PlanSignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@PlanSignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'PlanSignUpDeadline=' + convert(varchar,@PlanSignUpDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'PlanSignUpDeadline=NULL, ';
END
IF (@DeclineOrderDeadlineFlag Is Not NULL)
BEGIN
	IF (@DeclineOrderDeadline Is Not NULL)
		SET @SQL = @SQL + 'DeclineOrderDeadline=' + convert(varchar,@DeclineOrderDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'DeclineOrderDeadline=NULL, ';
END
IF (@OperationalStatusValueFlag Is Not NULL)
BEGIN
	IF (@OperationalStatusValue Is Not NULL)
		SET @SQL = @SQL + 'OperationalStatusValue=''' + @OperationalStatusValue + ''', ';
	ELSE
		SET @SQL = @SQL + 'OperationalStatusValue=NULL, ';
END
IF (@DBNotUploadedNotificationDaysFlag Is Not NULL)
BEGIN
	IF (@DBNotUploadedNotificationDays Is Not NULL)
		SET @SQL = @SQL + 'DBNotUploadedNotificationDays=' + convert(varchar,@DBNotUploadedNotificationDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'DBNotUploadedNotificationDays=NULL, ';
END
IF (@MailOrderDeclinedNotificationDaysFlag Is Not NULL)
BEGIN
	IF (@MailOrderDeclinedNotificationDays Is Not NULL)
		SET @SQL = @SQL + 'MailOrderDeclinedNotificationDays=' + convert(varchar,@MailOrderDeclinedNotificationDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MailOrderDeclinedNotificationDays=NULL, ';
END
IF (@MaterialOrderDeclinedNotificationDaysFlag Is Not NULL)
BEGIN
	IF (@MaterialOrderDeclinedNotificationDays Is Not NULL)
		SET @SQL = @SQL + 'MaterialOrderDeclinedNotificationDays=' + convert(varchar,@MaterialOrderDeclinedNotificationDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MaterialOrderDeclinedNotificationDays=NULL, ';
END
IF (@OrderNotFulfilledNotificationDaysFlag Is Not NULL)
BEGIN
	IF (@OrderNotFulfilledNotificationDays Is Not NULL)
		SET @SQL = @SQL + 'OrderNotFulfilledNotificationDays=' + convert(varchar,@OrderNotFulfilledNotificationDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrderNotFulfilledNotificationDays=NULL, ';
END
IF (@CreditCardExpirationDeadlineFlag Is Not NULL)
BEGIN
	IF (@CreditCardExpirationDeadline Is Not NULL)
		SET @SQL = @SQL + 'CreditCardExpirationDeadline=' + convert(varchar,@CreditCardExpirationDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'CreditCardExpirationDeadline=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE SystemDefaults SET ' + Left(@SQL, Len(@SQL)-1) + ' Where SystemDefaultsId = ' + convert(varchar,@SystemDefaultsId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
