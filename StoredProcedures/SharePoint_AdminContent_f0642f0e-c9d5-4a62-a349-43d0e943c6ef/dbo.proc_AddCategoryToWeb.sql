/****** Object:  StoredProcedure [dbo].[proc_AddCategoryToWeb]    Script Date: 5/15/2018 12:12:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddCategoryToWeb(
    @WebId uniqueidentifier,
    @Category nvarchar(128))
AS
    SET NOCOUNT ON
    IF NOT EXISTS(
        SELECT 
            * 
        FROM 
            WebCat 
        WHERE 
            WebId = @WebId AND
            Category = @Category)
    BEGIN
        INSERT INTO WebCat(
            WebId,
            CategoryId,
            Category)
        VALUES (
            @WebId,
            NEWID(),
            @Category)
    END

GO
