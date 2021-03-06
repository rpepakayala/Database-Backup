/****** Object:  StoredProcedure [dbo].[zw_upsert_AVIDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 

 
 
 
 

/******************************************* CREATE **************************************************/

CREATE PROCEDURE zw_upsert_AVIDatabase ( 
@AVID int  = NULL , 
@StoreID int  = NULL , 
@AVCode varchar(20)   = NULL , 
@PrintAs varchar(20)   = NULL , 
@Description varchar(50)   = NULL , 
@Question varchar(128)   = NULL , 
@AnswerStructure smallint  = NULL , 
@PricingStructure smallint  = NULL , 
@SetupCharge float  = NULL , 
@PerUnitPercentage float  = NULL , 
@MinPerUnitCharge float  = NULL , 
@MinTotalCharge float  = NULL , 
@MinPerAVCharge float  = NULL , 
@SortLevel int  = NULL , 
@DimensionUnits int  = NULL , 
@FixedPerPieceCharge float  = NULL , 
@FixedPerAVCharge float  = NULL , 
@PerPiecePerAVCharge float  = NULL , 
@AreaCharge float  = NULL , 
@LengthCharge float  = NULL , 
@FormulaCharge varchar(MAX)   = NULL , 
@PerimeterCharge float  = NULL , 
@AnswerRequired bit  = NULL , 
@SetupDouble bit  = NULL , 
@BaseDouble bit  = NULL , 
@MinDouble bit  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'AVI Database'
 
	 UPDATE [AVI Database] 
	 SET   
		[AVCode] = @AVCode, 
		[PrintAs] = @PrintAs, 
		[Description] = @Description, 
		[Question] = @Question, 
		[AnswerStructure] = @AnswerStructure, 
		[PricingStructure] = @PricingStructure, 
		[SetupCharge] = @SetupCharge, 
		[PerUnitPercentage] = @PerUnitPercentage, 
		[MinPerUnitCharge] = @MinPerUnitCharge, 
		[MinTotalCharge] = @MinTotalCharge, 
		[MinPerAVCharge] = @MinPerAVCharge, 
		[SortLevel] = @SortLevel, 
		[DimensionUnits] = @DimensionUnits, 
		[FixedPerPieceCharge] = @FixedPerPieceCharge, 
		[FixedPerAVCharge] = @FixedPerAVCharge, 
		[PerPiecePerAVCharge] = @PerPiecePerAVCharge, 
		[AreaCharge] = @AreaCharge, 
		[LengthCharge] = @LengthCharge, 
		[FormulaCharge] = @FormulaCharge, 
		[PerimeterCharge] = @PerimeterCharge, 
		[AnswerRequired] = @AnswerRequired, 
		[SetupDouble] = @SetupDouble, 
		[BaseDouble] = @BaseDouble, 
		[MinDouble] = @MinDouble, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [AVID] = @AVID
		AND [StoreID] = @StoreID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [AVI Database]( [AVID], [StoreID], [AVCode], [PrintAs], [Description], [Question], [AnswerStructure], [PricingStructure], [SetupCharge], [PerUnitPercentage], [MinPerUnitCharge], [MinTotalCharge], [MinPerAVCharge], [SortLevel], [DimensionUnits], [FixedPerPieceCharge], [FixedPerAVCharge], [PerPiecePerAVCharge], [AreaCharge], [LengthCharge], [FormulaCharge], [PerimeterCharge], [AnswerRequired], [SetupDouble], [BaseDouble], [MinDouble], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @AVID, @StoreID, @AVCode, @PrintAs, @Description, @Question, @AnswerStructure, @PricingStructure, @SetupCharge, @PerUnitPercentage, @MinPerUnitCharge, @MinTotalCharge, @MinPerAVCharge, @SortLevel, @DimensionUnits, @FixedPerPieceCharge, @FixedPerAVCharge, @PerPiecePerAVCharge, @AreaCharge, @LengthCharge, @FormulaCharge, @PerimeterCharge, @AnswerRequired, @SetupDouble, @BaseDouble, @MinDouble, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
