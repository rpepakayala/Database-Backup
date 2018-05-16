/****** Object:  View [dbo].[vw_Salesperson]    Script Date: 5/15/2018 12:14:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON




CREATE VIEW [dbo].[vw_Salesperson]
AS
-- Returns the salesperson for a jobid (You can right join)
    SELECT distinct
        jobs.job_id ,
        users.users_id ,
        users.first_name ,
        users.last_name ,
        users.active ,
        users.franchise_id
    FROM
        jobs
        LEFT JOIN job_entities ON jobs.job_id = job_entities.job_id
                                  AND job_entities.role_id = 'sales_person'
        LEFT JOIN users ON job_entities.entity_id = users.users_id



GO
