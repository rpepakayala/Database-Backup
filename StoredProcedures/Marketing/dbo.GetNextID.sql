/****** Object:  StoredProcedure [dbo].[GetNextID]    Script Date: 5/15/2018 12:10:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.GetNextID
  @TableName char(25),
  @FieldName char(25),
  @ReturnValue int output 
AS
DECLARE
  @CurrentID INT,
  @StartID INT,
  @EndID INT,
  @StepValue INT,
  @ID INT,
  @SQLStr varchar(4000),
  @ASqlString varchar(4000),
  @SelectSqlString varchar(4000);
    Set  @SelectSqlString =
         '
         Declare C1 cursor
            for
            SELECT CurrentID, StartID, EndID, StepValue
              FROM AutoInc WITH(TABLOCKX)
              WHERE TableName = '''+ @TableName +''' and FieldName = '''+ @FieldName +''';'
    Exec( @SelectSqlString)
      Open C1
        Fetch Next from C1 Into @CurrentID, @StartID, @EndID, @StepValue
        IF @@Fetch_Status = 0
          BEGIN
          IF (@CurrentID = @EndID)
            SET @ID = @StartID;
          ELSE
            SET @ID = @CurrentID + @StepValue;
 
          SET @SQLStr = '
            BEGIN TRANSACTION
            UPDATE AutoInc
              SET CurrentID =  '+ convert(varchar,@ID) +'
              WHERE TableName = '''+@TableName +''' and FieldName = '''+@FieldName +''' and CurrentID = '+ convert(varchar, @CurrentID) +';
  
            COMMIT TRANSACTION'
          Exec (@Sqlstr)
          END
        ELSE
         BEGIN
	    Set  @ASqlString =  '
	         Declare C2 cursor
	            for
        	 	   Select  max('+@FieldName+') as id from  '+ @TableName 	    
	
	    Exec( @ASqlString)
	      Open C2
	        Fetch Next from C2 Into @ID
	       select @ID = ISNULL(@ID,0) + 1
		close C2
	       deallocate C2
          SET @SQLStr = '
            BEGIN TRANSACTION
            INSERT INTO AutoInc (TableName, FieldName, StartID, StepValue, CurrentID) 
              values(''' + @TableName+''', ''' + @FieldName+''', 1, 1, '+convert(VarChar,@ID) +')
            COMMIT TRANSACTION'
          Exec (@Sqlstr)
         END
       close C1
       deallocate C1
  Select @ReturnValue = @ID


GO
