/****** Object:  StoredProcedure [dbo].[zw_upsert_CourseTerm]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_CourseTerm] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@CourseTermTypeID int  = NULL , 
@CourseID int  = NULL , 
@CourseClassTypeID int  = NULL , 
@InstructorID1 int  = NULL , 
@InstructorID2 int  = NULL , 
@InstructorID3 int  = NULL , 
@StartDate datetime  = NULL , 
@EndDate datetime  = NULL , 
@DefaultLocationID int  = NULL , 
@DefaultLocationStoreID int  = NULL , 
@DefaultLocationClassTypeID int  = NULL , 
@DisplayName varchar(30)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CourseTerm] 
	 SET   
		[StoreID] = @StoreID, 
		[ClassTypeID] = @ClassTypeID, 
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[CourseTermTypeID] = @CourseTermTypeID, 
		[CourseID] = @CourseID, 
		[CourseClassTypeID] = @CourseClassTypeID, 
		[InstructorID1] = @InstructorID1, 
		[InstructorID2] = @InstructorID2, 
		[InstructorID3] = @InstructorID3, 
		[StartDate] = @StartDate, 
		[EndDate] = @EndDate, 
		[DefaultLocationID] = @DefaultLocationID, 
		[DefaultLocationStoreID] = @DefaultLocationStoreID, 
		[DefaultLocationClassTypeID] = @DefaultLocationClassTypeID, 
		[DisplayName] = @DisplayName, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [CourseTerm]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [CourseTermTypeID], [CourseID], [CourseClassTypeID], [InstructorID1], [InstructorID2], [InstructorID3], [StartDate], [EndDate], [DefaultLocationID], [DefaultLocationStoreID], [DefaultLocationClassTypeID], [DisplayName], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @CourseTermTypeID, @CourseID, @CourseClassTypeID, @InstructorID1, @InstructorID2, @InstructorID3, @StartDate, @EndDate, @DefaultLocationID, @DefaultLocationStoreID, @DefaultLocationClassTypeID, @DisplayName, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
