/****** Object:  UserDefinedFunction [dbo].[RetainedEarnings]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION RetainedEarnings (
	-- Add the parameters for the function here
	@StartDate datetime,
	@DivisionID int
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result float;
	DECLARE @LastYTD datetime;

	-- First Look up the last Yearly closeout before the passed date
	Set @LastYTD = Coalesce( (Select Max(Journal.EndDateTime) 
                   from Journal 
                   where ClassTypeID = 8913
					and Journal.StartDateTime <= @StartDate and EndDateTime IS NOT NULL),
				'1/1/'+Cast(YEAR(@StartDate) as VarChar(4)));
	
    --IF @LastYTD = NULL 
	--	set @LastYTD = '1/1/'+Cast(YEAR(@StartDate) as VarChar(4));

	-- Now calculate the Earnings for the TimeFrame specified
	SET @Result = (Select Sum(Amount) 
                  from GL 
				  where EntryDateTime < @LastYTD
					and ( (@DivisionID=-1) or (GL.DivisionID=@DivisionID))
				    and GLClassificationType between 4000 and 5999);
	
	-- Return the result of the function
	RETURN @Result

END

GO
