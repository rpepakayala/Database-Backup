/****** Object:  StoredProcedure [dbo].[proc_getNewObjects]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getNewObjects
(
    @NewestCachedVersion rowversion
) AS
    SET NOCOUNT ON
    DECLARE @LastUpdateVersion rowversion
    SELECT 
        @LastUpdateVersion = Version 
    FROM
        LastUpdate
    WHERE
        Value = 0
    IF (@LastUpdateVersion < @NewestCachedVersion)
    BEGIN
        RETURN 0
    END
    BEGIN TRAN
    SELECT 
        Version 
    FROM
        LastUpdate
    WHERE
        Value = 0
    SELECT
        Id,
        ParentId,
        ClassId,
        Name,
        Status,
        Version,
        Properties
    FROM
        Objects
    WHERE
        Version > @NewestCachedVersion
    SELECT
        Dependencies.DependantId
    FROM
        Objects
    INNER JOIN 
        Dependencies
    ON 
        Objects.Id = Dependencies.ObjectId
    WHERE
        Objects.Version > @NewestCachedVersion
    SELECT 
	Id,
	Version
    FROM
        Tombstones
    WHERE
        Version > @NewestCachedVersion        
    COMMIT TRAN
    RETURN 0

GO
