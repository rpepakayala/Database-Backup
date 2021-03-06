/****** Object:  View [dbo].[vw_rpt_AcctManager]    Script Date: 5/15/2018 12:14:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE VIEW [dbo].[vw_rpt_AcctManager]
AS
Select Distinct
  users.users_id,
  job_entities.job_id,
  users.first_name,
  users.last_name,
  users.active,
  users.franchise_id
From
  jobs
  Left Join job_entities On jobs.job_id = job_entities.job_id And
    job_entities.role_id = 'account_manager'
  Left Join users On job_entities.entity_id = users.users_id

GO
