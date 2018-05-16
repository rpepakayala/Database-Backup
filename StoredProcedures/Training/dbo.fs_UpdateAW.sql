/****** Object:  StoredProcedure [dbo].[fs_UpdateAW]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE fs_UpdateAW 
(   @UserID int,
    @ModuleID int,
    @TotalTime varchar(20),
    @LastPage varchar(20),
    @Menuvar varchar(50),
    @Score1 varchar(20),
    @Score2 varchar(20)   )
AS
UPDATE AWUserModules
SET 
TotalTime = @TotalTime,
LastPage = @LastPage,
Menuvar = @Menuvar,
Score1 = @Score1,
Score2 = @Score2
WHERE UserID = @UserID
AND ModuleID = @ModuleID
GO
