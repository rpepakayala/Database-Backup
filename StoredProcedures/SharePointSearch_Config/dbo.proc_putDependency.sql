/****** Object:  StoredProcedure [dbo].[proc_putDependency]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_putDependency
(
    @ObjectId uniqueidentifier,
    @DependantId uniqueidentifier
) AS
    SET NOCOUNT ON
    IF (@ObjectId IS NOT NULL)
    BEGIN
        INSERT INTO Dependencies (ObjectId, DependantId) VALUES(@ObjectId, @DependantId)
    END
    RETURN 0 

GO
