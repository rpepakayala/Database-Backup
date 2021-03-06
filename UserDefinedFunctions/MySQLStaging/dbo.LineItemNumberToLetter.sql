/****** Object:  UserDefinedFunction [dbo].[LineItemNumberToLetter]    Script Date: 5/15/2018 12:15:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION [dbo].[LineItemNumberToLetter] ( @LineNumer INT )
RETURNS CHAR(1) 	WITH schemabinding
AS 
    BEGIN
        RETURN CASE @LineNumer 
		WHEN 1 THEN 'A'
		WHEN 2 THEN 'B'
		WHEN 3 THEN 'C'
		WHEN 4 THEN 'D'
		WHEN 5 THEN 'E'
		WHEN 6 THEN 'F'
		WHEN 7 THEN 'G'
		WHEN 8 THEN 'H'
		WHEN 9 THEN 'I'
		WHEN 10 THEN 'J'
		WHEN 11 THEN 'K'
		WHEN 12 THEN 'L'
		WHEN 13 THEN 'M'
		WHEN 14 THEN 'N'
		WHEN 15 THEN 'O'
		WHEN 16 THEN 'P'
		WHEN 17 THEN 'Q'
		WHEN 18 THEN 'R'
		WHEN 19 THEN 'S'
		WHEN 20 THEN 'T'
		WHEN 21 THEN 'U'
		WHEN 22 THEN 'V'
		WHEN 23 THEN 'W'
		WHEN 24 THEN 'X'
		WHEN 25 THEN 'Y'
		WHEN 26 THEN 'Z'
		ELSE ' '
	END    

    END

	
GO
