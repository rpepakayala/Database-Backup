/****** Object:  UserDefinedFunction [dbo].[IsAllPrintableCharacters]    Script Date: 5/15/2018 12:14:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE FUNCTION [dbo].[IsAllPrintableCharacters]( 
@string varchar(max) = ''
)

RETURNS bit AS  
BEGIN
   DECLARE @return BIT 
   DECLARE @position INT 

   SET @position = 1 

   WHILE @position <= DATALENGTH(@string) 
   BEGIN 
       IF ASCII(SUBSTRING(@string, @position, 1)) BETWEEN 32 AND 126  
           SELECT @return = 1
       ELSE 
           SELECT @return = 0

       IF @return <> 0
           SET @position = @position + 1 
       ELSE 
           GOTO ExitUDF 
END 

ExitUDF: 
RETURN @return 
END

GO
