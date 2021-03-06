/****** Object:  View [dbo].[vw_Owners]    Script Date: 5/15/2018 12:14:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Owners
as SELECT
    [users_id]
,   [user_types_id]
,   [franchise_id]
,   [accounts_id]
,   u.[role_id]
,   [first_name]
,   [last_name]
,   [active]
FROM
    [MySQLStaging].[dbo].[users] u
    INNER JOIN roles r ON u.role_id = r.role_id
WHERE   
    r.name = 'owners'
    AND u.active = 1

GO
