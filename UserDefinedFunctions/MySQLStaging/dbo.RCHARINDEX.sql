/****** Object:  UserDefinedFunction [dbo].[RCHARINDEX]    Script Date: 5/15/2018 12:15:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com   
-- Similar to the Transact-SQL function Charindex, with a Right search
-- Example
-- select dbo.RCHARINDEX('me', 'Now is the time for all good men', 1)  --  Displays 30
CREATE FUNCTION RCHARINDEX
    (
      @expression1 NVARCHAR(4000) ,
      @expression2 NVARCHAR(4000) ,
      @start_location SMALLINT = 1 
    )
RETURNS NVARCHAR(4000)
AS 
    BEGIN
        DECLARE @StartingPosition SMALLINT
        SET @StartingPosition = CHARINDEX(REVERSE(@expression1) COLLATE Latin1_General_BIN,
                                          REVERSE(@expression2) COLLATE Latin1_General_BIN,
                                          @start_location)

        RETURN CASE 
               WHEN  @StartingPosition > 0
               THEN  2 - @StartingPosition + DATALENGTH(@expression2)/(CASE SQL_VARIANT_PROPERTY(@expression2,'BaseType') WHEN 'nvarchar' THEN 2  ELSE 1 END) 
                       - DATALENGTH(@expression1)/(CASE SQL_VARIANT_PROPERTY(@expression1,'BaseType') WHEN 'nvarchar' THEN 2  ELSE 1 END)  -- for unicode  
            ELSE 0 
            END
    END

GO
