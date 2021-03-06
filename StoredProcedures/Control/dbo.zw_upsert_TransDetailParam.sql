/****** Object:  StoredProcedure [dbo].[zw_upsert_TransDetailParam]    Script Date: 5/15/2018 12:09:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_TransDetailParam ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ParentID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@TransactionType int  = NULL , 
@TransHeaderID int  = NULL , 
@TransHeaderClassTypeID int  = NULL , 
@ParameterID int  = NULL , 
@ParameterClassTypeID int  = NULL , 
@ParameterName [nvarchar](25)   = NULL , 
@FormattedText [nvarchar](MAX)   = NULL , 
@ListID int  = NULL , 
@ListValue int  = NULL , 
@Units int  = NULL , 
@ValueType int  = NULL , 
@ValueAsString [nvarchar](MAX)   = NULL , 
@ValueAsFloat float  = NULL , 
@ValueAsInteger int  = NULL , 
@ValueAsDateTime datetime  = NULL , 
@ValueAsBinary image  = NULL , 
@ValueAsBlob image  = NULL , 
@ValueAsStr25 [nvarchar](25)   = NULL , 
@BlobType int  = NULL , 
@Overridden bit  = NULL , 
@VariableID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [TransDetailParam] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ParentID] = @ParentID, 
		[ParentClassTypeID] = @ParentClassTypeID, 
		[TransactionType] = @TransactionType, 
		[TransHeaderID] = @TransHeaderID, 
		[TransHeaderClassTypeID] = @TransHeaderClassTypeID, 
		[ParameterID] = @ParameterID, 
		[ParameterClassTypeID] = @ParameterClassTypeID, 
		[ParameterName] = @ParameterName, 
		[FormattedText] = @FormattedText, 
		[ListID] = @ListID, 
		[ListValue] = @ListValue, 
		[Units] = @Units, 
		[ValueType] = @ValueType, 
		[ValueAsString] = @ValueAsString, 
		[ValueAsFloat] = @ValueAsFloat, 
		[ValueAsInteger] = @ValueAsInteger, 
		[ValueAsDateTime] = @ValueAsDateTime, 
		[ValueAsBinary] = @ValueAsBinary, 
		[ValueAsBlob] = @ValueAsBlob, 
		[ValueAsStr25] = @ValueAsStr25, 
		[BlobType] = @BlobType, 
		[Overridden] = @Overridden, 
		[VariableID] = @VariableID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [TransDetailParam]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ParentID], [ParentClassTypeID], [TransactionType], [TransHeaderID], [TransHeaderClassTypeID], [ParameterID], [ParameterClassTypeID], [ParameterName], [FormattedText], [ListID], [ListValue], [Units], [ValueType], [ValueAsString], [ValueAsFloat], [ValueAsInteger], [ValueAsDateTime], [ValueAsBinary], [ValueAsBlob], [ValueAsStr25], [BlobType], [Overridden], [VariableID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ParentID, @ParentClassTypeID, @TransactionType, @TransHeaderID, @TransHeaderClassTypeID, @ParameterID, @ParameterClassTypeID, @ParameterName, @FormattedText, @ListID, @ListValue, @Units, @ValueType, @ValueAsString, @ValueAsFloat, @ValueAsInteger, @ValueAsDateTime, @ValueAsBinary, @ValueAsBlob, @ValueAsStr25, @BlobType, @Overridden, @VariableID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
