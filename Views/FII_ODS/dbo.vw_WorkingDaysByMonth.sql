/****** Object:  View [dbo].[vw_WorkingDaysByMonth]    Script Date: 5/15/2018 12:13:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[vw_WorkingDaysByMonth]
AS
Select
    Year(System.Calendar.dt) As intYear,
    Month(System.Calendar.dt) As intMonth,
    Count(*) As WorkDays
  From
    System.Calendar   WITH ( NOLOCK ) 
  Where
    System.Calendar.IsWorkDay = 1
  Group By
    Year(System.Calendar.dt), Month(System.Calendar.dt)

GO
