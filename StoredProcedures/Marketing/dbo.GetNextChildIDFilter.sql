/****** Object:  StoredProcedure [dbo].[GetNextChildIDFilter]    Script Date: 5/15/2018 12:10:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.GetNextChildIDFilter
  @TableName char(25),
  @filter varchar(4000),
  @FieldName char(25),
  @ReturnValue int output 
AS
  Declare @ID int
  Declare @SQL varchar(1000)
  Set @ID=1
  Set  @SQL =
         '
         Declare C1 cursor
            for
            Select Max(' + Convert(varchar, @FieldName) + ') From ' +  Convert(varchar, @TableName) + '
	Where ' +@Filter + ';'
    Exec( @SQL)
      Open C1
        Fetch Next from C1 Into @ID
        IF @@Fetch_Status = 0
          BEGIN
		If @ID is Null
			Set @ID = 1;
		Else
			Set @ID = @ID + 1;
          END
       close C1
     deallocate C1
   Select @ReturnValue = @ID


GO
