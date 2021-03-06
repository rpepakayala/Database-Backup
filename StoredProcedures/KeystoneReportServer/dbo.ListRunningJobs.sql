/****** Object:  StoredProcedure [dbo].[ListRunningJobs]    Script Date: 5/15/2018 12:10:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[ListRunningJobs]
AS
SELECT JobID, StartDate, ComputerName, RequestName, RequestPath, SUSER_SNAME(Users.[Sid]), Users.[UserName], Description, 
    Timeout, JobAction, JobType, JobStatus, Users.[AuthType]
FROM RunningJobs 
INNER JOIN Users 
ON RunningJobs.UserID = Users.UserID

GO
