/****** Object:  UserDefinedFunction [dbo].[CurrentEarnings]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION CurrentEarnings (
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
    -- If no closeout date is found use the beginning of the year
	Set @LastYTD = Coalesce( (Select Max(Journal.EndDateTime) 
                   from Journal 
                   where ClassTypeID = 8913
					and Journal.StartDateTime <= @StartDate and EndDateTime IS NOT NULL),
				             '1/1/'+Cast(YEAR(@StartDate) as VarChar(4)));


	-- Now calculate the Earnings for the TimeFrame specified
	SET @Result = (Select Sum(Amount) 
                  from GL 
				  where EntryDateTime between @LastYTD and @StartDate
					and ( (@DivisionID=-1) or (GL.DivisionID=@DivisionID))
				    and GLClassificationType between 4000 and 5999);
	
	-- Return the result of the function
	RETURN @Result

END

GO
