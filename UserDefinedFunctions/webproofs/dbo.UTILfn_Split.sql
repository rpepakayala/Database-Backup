/****** Object:  UserDefinedFunction [dbo].[UTILfn_Split]    Script Date: 5/15/2018 12:15:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE function dbo.UTILfn_Split(
 @String nvarchar (100),
 @Delimiter nvarchar (10)
 )
returns @ValueTable table ([Value] nvarchar(100))
begin
 declare @NextString nvarchar(100)
 declare @Pos int
 declare @NextPos int
 declare @CommaCheck nvarchar(1)
 
 --Initialize
 set @NextString = ''
 set @CommaCheck = right(@String,1) 
 
 --Check for trailing Comma, if not exists, INSERT
 --if (@CommaCheck <> @Delimiter )
 set @String = @String + @Delimiter
 
 --Get position of first Comma
 set @Pos = charindex(@Delimiter,@String)
 set @NextPos = 1
 
 --Loop while there is still a comma in the String of levels
 while (@pos <>  0)  
 begin
  set @NextString = substring(@String,1,@Pos - 1)
 
  insert into @ValueTable ( [Value]) Values (@NextString)
 
  set @String = substring(@String,@pos +1,len(@String))
  
  set @NextPos = @Pos
  set @pos  = charindex(@Delimiter,@String)
 end
 
 return
end
GO
