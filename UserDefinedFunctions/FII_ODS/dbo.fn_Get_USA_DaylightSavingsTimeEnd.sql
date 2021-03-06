/****** Object:  UserDefinedFunction [dbo].[fn_Get_USA_DaylightSavingsTimeEnd]    Script Date: 5/15/2018 12:14:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE function [dbo].[fn_Get_USA_DaylightSavingsTimeEnd]
/*
		2005 and Before:
Begins the first Sunday in April clocks are set ahead one hour, so 2:00 a.m. becomes 3:00 a.m.
Ends the last Sunday in October clocks are set back one hour, so 2:00 a.m. becomes 1:00 a.m.
2006 and After:
Ends the second Sunday in March clocks are set ahead one hour, so 2:00 a.m. becomes 3:00 a.m.
Ends the first Sunday in November clocks are set back one hour, so 2:00 a.m. becomes 1:00 a.m.

*/

(@Year varchar(4))
RETURNS smalldatetime
as
begin
declare @DTSEndWeek smalldatetime
set @DTSEndWeek = CASE When @Year < '2006' then '10/01/' else '11/01/' end  + convert(varchar,@Year)
return case datepart(dw,dateadd(week,1,@DTSEndWeek))
when 1 then
dateadd(hour,2,@DTSEndWeek)
when 2 then
dateadd(hour,146,@DTSEndWeek)
when 3 then
dateadd(hour,122,@DTSEndWeek)
when 4 then
dateadd(hour,98,@DTSEndWeek)
when 5 then 
dateadd(hour,74,@DTSEndWeek)
when 6 then 
dateadd(hour,50,@DTSEndWeek)
when 7 then 
dateadd(hour,26,@DTSEndWeek)
end
end

GO
