/****** Object:  StoredProcedure [dbo].[proc_SecGetGroupOwner]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetGroupOwner(
    @SiteId uniqueidentifier,
    @GroupId int,
    @OwnerId int OUTPUT)
AS
    SET NOCOUNT ON    
    SELECT 
        @OwnerId = Owner 
    FROM
        Groups
    WHERE
        SiteId = @SiteId AND 
        ID = @GroupId
    IF @OwnerId IS NULL
    BEGIN
        SET @OwnerId = -1
        RETURN 1319
    END
    RETURN 0

GO
