/****** Object:  StoredProcedure [dbo].[sp_get_script]    Script Date: 5/15/2018 12:10:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE sp_get_script
    @name sysname
AS
BEGIN
    exec master.dbo.xp_get_script @name
END

GO
