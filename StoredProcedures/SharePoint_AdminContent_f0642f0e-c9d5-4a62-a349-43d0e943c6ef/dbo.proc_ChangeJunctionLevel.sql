/****** Object:  StoredProcedure [dbo].[proc_ChangeJunctionLevel]    Script Date: 5/15/2018 12:12:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_ChangeJunctionLevel(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),    
    @Level tinyint,
    @NewLevel tinyint
    )
AS
    SET NOCOUNT ON
    IF @Level <> @NewLevel
    BEGIN
        DELETE
            UserDataJunctions
        WHERE
            tp_SiteId = @SiteId AND
            tp_DirName = @DirName AND
            tp_LeafName = @LeafName AND
            tp_Level = @NewLevel
    END
    UPDATE
        UserDataJunctions
    SET
        tp_Level = @NewLevel
    WHERE
        tp_SiteId = @SiteId AND
        tp_DirName = @DirName AND
        tp_LeafName = @LeafName AND
        tp_Level = @Level

GO
