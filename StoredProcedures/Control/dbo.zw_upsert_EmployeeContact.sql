/****** Object:  StoredProcedure [dbo].[zw_upsert_EmployeeContact]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_EmployeeContact ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@FirstName [nvarchar](25)   = NULL , 
@LastName [nvarchar](25)   = NULL , 
@Title [nvarchar](10)   = NULL , 
@Position [nvarchar](25)   = NULL , 
@EmailAddress [nvarchar](50)   = NULL , 
@MainPhoneNumberID int  = NULL , 
@MainFaxNumberID int  = NULL , 
@EmployeeID int  = NULL , 
@PrimaryNumber varchar(75)  = NULL , 
@PriNumberTypeID int  = NULL , 
@PriNumberTypeText varchar(50)  = NULL , 
@SecondaryNumber varchar(75)  = NULL , 
@SecNumberTypeID int  = NULL , 
@SecNumberTypeText varchar(50)  = NULL , 
@ThirdNumber varchar(75)  = NULL , 
@ThirdNumberTypeID int  = NULL , 
@ThirdNumberTypeText varchar(50)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [EmployeeContact] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[Notes] = @Notes, 
		[FirstName] = @FirstName, 
		[LastName] = @LastName, 
		[Title] = @Title, 
		[Position] = @Position, 
		[EmailAddress] = @EmailAddress, 
		[MainPhoneNumberID] = @MainPhoneNumberID, 
		[MainFaxNumberID] = @MainFaxNumberID, 
		[EmployeeID] = @EmployeeID, 
		[PrimaryNumber] = @PrimaryNumber, 
		[PriNumberTypeID] = @PriNumberTypeID, 
		[PriNumberTypeText] = @PriNumberTypeText, 
		[SecondaryNumber] = @SecondaryNumber, 
		[SecNumberTypeID] = @SecNumberTypeID, 
		[SecNumberTypeText] = @SecNumberTypeText, 
		[ThirdNumber] = @ThirdNumber, 
		[ThirdNumberTypeID] = @ThirdNumberTypeID, 
		[ThirdNumberTypeText] = @ThirdNumberTypeText, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [EmployeeContact]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [Notes], [FirstName], [LastName], [Title], [Position], [EmailAddress], [MainPhoneNumberID], [MainFaxNumberID], [EmployeeID], [PrimaryNumber], [PriNumberTypeID], [PriNumberTypeText], [SecondaryNumber], [SecNumberTypeID], [SecNumberTypeText], [ThirdNumber], [ThirdNumberTypeID], [ThirdNumberTypeText], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @Notes, @FirstName, @LastName, @Title, @Position, @EmailAddress, @MainPhoneNumberID, @MainFaxNumberID, @EmployeeID, @PrimaryNumber, @PriNumberTypeID, @PriNumberTypeText, @SecondaryNumber, @SecNumberTypeID, @SecNumberTypeText, @ThirdNumber, @ThirdNumberTypeID, @ThirdNumberTypeText, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
