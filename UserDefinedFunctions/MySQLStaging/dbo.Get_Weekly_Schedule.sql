/****** Object:  UserDefinedFunction [dbo].[Get_Weekly_Schedule]    Script Date: 5/15/2018 12:15:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		SMT
-- Retrieves all of the schedule events for the given week
-- =============================================
CREATE FUNCTION Get_Weekly_Schedule
    (
      @franchise_id VARCHAR(32),@week INT , @year INT 
    )
RETURNS TABLE
AS
RETURN
    ( SELECT
    c.calendar_dt ,
    c.week_no ,
    et.employee_time_id ,
    et.employee_data_id ,
    et.shift_start ,
    et.start_actual_time ,
    et.shift_end ,
    et.end_actual_time ,
    et.shift_cumulative_time ,
    et.adjusted_cumulative_time ,
    et.approved_on ,
    et.approved_by ,
    et.shift_type ,
    et.notes ,
    name = u.first_name + ' ' + u.last_name ,
    approved_name = u1.first_name + ' ' + u1.last_name
FROM
    calendar c
    LEFT JOIN employee_time et ON c.calendar_dt = et.calendar_dt
                                 -- AND franchise_id = @franchise_id
    LEFT JOIN employee_data ed ON et.employee_data_id = ed.employee_data_id
    LEFT JOIN users u ON ed.users_id = u.users_id
    LEFT JOIN employee_data ed1 ON et.approved_by = ed1.employee_data_id
    LEFT JOIN users u1 ON ed1.users_id = u1.users_id
WHERE
    week_no = @week
    AND year_no = @year
--ORDER BY
--    c.calendar_dt ,
--    u.last_name ,
--    u.first_name
    )

GO
