/****** Object:  StoredProcedure [dbo].[fsi_split_singlename]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[fsi_split_singlename] (
@singlename varchar(100),
@first varchar(50) OUTPUT,
@last varchar(50) OUTPUT
)  
AS  
SET NOCOUNT ON
DECLARE @position int
SET @singlename = LTRIM(RTRIM(@singlename))
SET @position = CHARINDEX( ' ', @singlename, 1)
IF @position < 1
	BEGIN
		SET @first = ''
		SET @last = @singlename
		RETURN 1
	END
ELSE
	BEGIN
		SET @first = SUBSTRING( @singlename, 1, (@position-1) )
		SET @position = @position + 1
		
		WHILE( CHARINDEX( ' ', @singlename, @position) > 0 )
			BEGIN
				SET @position = CHARINDEX( ' ', @singlename, @position)+1
			END
		SET @last = SUBSTRING( @singlename, @position, (len(@singlename)-@position)+1)
	END

GO
