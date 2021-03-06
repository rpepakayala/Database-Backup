/****** Object:  StoredProcedure [dbo].[proc_putObject]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_putObject
(
    @Id uniqueidentifier,
    @ParentId uniqueidentifier,
    @ClassId uniqueidentifier,
    @Name nvarchar(128),
    @Status int, 
    @Version rowversion, 
    @Properties ntext,
    @ExistingObject uniqueidentifier output,
    @NewVersion rowversion output
) AS
    SET NOCOUNT ON
    DECLARE @LastUpdateVersion rowversion
    SELECT 
        @LastUpdateVersion = Version 
    FROM
        LastUpdate WITH (updlock)
    WHERE
        Value = 0
    DECLARE @CurrentVersion rowversion
    SELECT 
        @CurrentVersion = Version 
    FROM 
        Objects WITH (updlock)
    WHERE 
        Id = @Id
    IF (@@ROWCOUNT = 0)
    BEGIN
        IF (@Version IS NOT NULL)
        BEGIN
            RETURN 1  
        END
        IF NOT EXISTS (SELECT * FROM Classes WHERE Id = @ClassId)
        BEGIN
            RETURN 2 
        END
	SELECT 
	    @ExistingObject = Id
	FROM 
	    Objects
	WHERE 
	    ParentId = @ParentId AND
	    ClassId = @ClassId AND
	    Name = @Name
	IF (@@ROWCOUNT <> 0)
	BEGIN
	    RETURN 8 -- object exists
	END
        INSERT INTO Objects
        (
            Id,
            ParentId,
            ClassId,
            Name,
            Status,
            Properties
        )
        VALUES
        (
            @Id,
            @ParentId,
            @ClassId,
            @Name,
            @Status,
            @Properties
        )
        IF (@@rowcount != 1)
        BEGIN
            RETURN 3 
        END
	DELETE FROM
	    Tombstones
	WHERE
	    Id = @Id
    END
    ELSE
    BEGIN
        IF (@Version IS NULL)
        BEGIN
	    RETURN 9 -- object exists
        END
        IF (@CurrentVersion != @Version AND @Version IS NOT NULL)
        BEGIN
            RETURN 4 
        END
        DELETE FROM
            Dependencies
        WHERE
            DependantId = @Id
        UPDATE 
            Objects
        SET
            Name = @Name,
            Status = @Status,
            Properties = @Properties
        WHERE
            Id = @Id
        IF (@@ROWCOUNT != 1)
        BEGIN
            RETURN 5 
        END
    END
    SELECT
        @NewVersion = Version 
    FROM
        Objects
    WHERE
        Id = @Id
    IF (@NewVersion IS NULL)
    BEGIN
        RETURN 6 
    END
    RETURN 0 

GO
